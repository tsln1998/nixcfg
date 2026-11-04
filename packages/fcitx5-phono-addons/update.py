#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update the Phono addon release and unpacked source hash. Requires Nix."""

import argparse
import json
import re
import ssl
import subprocess
import sys
import tempfile
from pathlib import Path
from urllib.request import Request, urlopen

import certifi

REPOSITORY = "phono-project/phono-fcitx5-addon"
UPDATE_PATH = Path(__file__).resolve().with_name("update.json")


def fetch_text(url: str, context: ssl.SSLContext) -> str:
    request = Request(url, headers={"User-Agent": "nixos-fcitx5-phono-addons-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        return response.read().decode("utf-8")


def fetch_json(url: str, context: ssl.SSLContext) -> dict:
    return json.loads(fetch_text(url, context))


def github_source(repository: str, revision: str) -> dict:
    url = f"https://codeload.github.com/{repository}/tar.gz/{revision}"
    result = subprocess.run(
        [
            "nix",
            "store",
            "prefetch-file",
            "--json",
            "--hash-type",
            "sha256",
            "--unpack",
            "--name",
            "source",
            url,
        ],
        check=True,
        stdout=subprocess.PIPE,
        text=True,
        timeout=180,
    )
    return {"url": url, "hash": json.loads(result.stdout)["hash"]}


def fetch_latest_sources() -> dict:
    context = ssl.create_default_context(cafile=certifi.where())
    release = fetch_json(
        f"https://api.github.com/repos/{REPOSITORY}/releases/latest", context
    )
    tag = release["tag_name"]
    if release["draft"] or release["prerelease"]:
        raise ValueError(f"Expected a stable release, got {tag!r}")
    if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError(f"Unexpected release tag: {tag!r}")

    return {"version": tag.removeprefix("v"), **github_source(REPOSITORY, tag)}


def write_if_changed(path: Path, sources: dict, *, check: bool = False) -> bool:
    """Write atomically only after all downloads succeed; --check never writes."""
    content = json.dumps(sources, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False
    if not check:
        with tempfile.TemporaryDirectory(
            prefix=".fcitx5-phono-addons-update-", dir=path.parent
        ) as directory:
            temporary_path = Path(directory) / path.name
            temporary_path.write_text(content, encoding="utf-8")
            temporary_path.replace(path)
    return True


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="report pending updates without writing update.json",
    )
    args = parser.parse_args()
    try:
        sources = fetch_latest_sources()
        changed = write_if_changed(UPDATE_PATH, sources, check=args.check)
    except (
        OSError,
        ValueError,
        KeyError,
        TypeError,
        subprocess.SubprocessError,
    ) as error:
        print(f"Failed to update Phono addon source: {error}", file=sys.stderr)
        return 1

    if changed and args.check:
        print("update.json is out of date, rerun without --check", file=sys.stderr)
        return 1
    if changed:
        print(f"Updated {UPDATE_PATH}")
    else:
        print("Phono addon source is already up to date")
    return 0


if __name__ == "__main__":
    sys.exit(main())
