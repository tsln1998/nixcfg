#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Pin the PhonoP2C W8A8 model snapshot and file hashes. Requires Nix."""

import argparse
import base64
import json
import re
import ssl
import subprocess
import sys
import tempfile
from pathlib import Path, PurePosixPath
from urllib.parse import quote
from urllib.request import Request, urlopen

import certifi

REPOSITORY = "afirelily/phonop2c_v2_2_base_w8a8_model"
UPDATE_PATH = Path(__file__).resolve().with_name("update.json")
REQUIRED_FILES = {
    "config.json",
    "bins/pre_model.pte",
    "bins/post_model.pte",
    "bins/pinyin_segment.pte",
    "vocabs/chinese_vocab.txt",
    "vocabs/context_vocab.txt",
    "vocabs/pinyin_vocab.txt",
    "vocabs/pinyin_char_vocab.txt",
}


def fetch_json(url: str, context: ssl.SSLContext):
    request = Request(url, headers={"User-Agent": "nixos-fcitx5-phono-model-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        return json.load(response)


def file_source(entry: dict, revision: str) -> tuple[str, dict]:
    path = entry["path"]
    if (
        not path
        or PurePosixPath(path).is_absolute()
        or ".." in PurePosixPath(path).parts
    ):
        raise ValueError(f"Invalid model path: {path!r}")
    url = f"https://huggingface.co/{REPOSITORY}/resolve/{revision}/{quote(path)}"
    if "lfs" in entry:
        digest = entry["lfs"]["oid"]
        if not re.fullmatch(r"[0-9a-f]{64}", digest):
            raise ValueError(f"Invalid LFS SHA256 for {path!r}")
        checksum = "sha256-" + base64.b64encode(bytes.fromhex(digest)).decode("ascii")
    else:
        result = subprocess.run(
            [
                "nix",
                "store",
                "prefetch-file",
                "--json",
                "--hash-type",
                "sha256",
                "--name",
                PurePosixPath(path).name,
                url,
            ],
            check=True,
            stdout=subprocess.PIPE,
            text=True,
            timeout=180,
        )
        checksum = json.loads(result.stdout)["hash"]
    return path, {"url": url, "hash": checksum}


def fetch_latest_sources() -> dict:
    context = ssl.create_default_context(cafile=certifi.where())
    info = fetch_json(f"https://huggingface.co/api/models/{REPOSITORY}", context)
    revision = info["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError(f"Invalid model revision: {revision!r}")
    entries = fetch_json(
        f"https://huggingface.co/api/models/{REPOSITORY}/tree/{revision}?recursive=true&expand=false",
        context,
    )
    files = dict(
        file_source(entry, revision)
        for entry in entries
        if entry["type"] == "file" and entry["path"] != ".gitattributes"
    )
    missing = REQUIRED_FILES - files.keys()
    if missing:
        raise ValueError(f"Incomplete model snapshot, missing {sorted(missing)}")
    return {"version": revision[:7], "revision": revision, "files": files}


def write_if_changed(path: Path, sources: dict, *, check: bool = False) -> bool:
    content = json.dumps(sources, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False
    if not check:
        with tempfile.TemporaryDirectory(
            prefix=".fcitx5-phono-model-update-", dir=path.parent
        ) as directory:
            temporary_path = Path(directory) / path.name
            temporary_path.write_text(content, encoding="utf-8")
            temporary_path.replace(path)
    return True


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check", action="store_true", help="check for updates without writing"
    )
    args = parser.parse_args()
    try:
        changed = write_if_changed(
            UPDATE_PATH, fetch_latest_sources(), check=args.check
        )
    except (
        OSError,
        ValueError,
        KeyError,
        TypeError,
        subprocess.SubprocessError,
    ) as error:
        print(f"Failed to update PhonoP2C model: {error}", file=sys.stderr)
        return 1
    if changed and args.check:
        print("update.json is out of date, rerun without --check", file=sys.stderr)
        return 1
    print(
        f"Updated {UPDATE_PATH}" if changed else "PhonoP2C model is already up to date"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
