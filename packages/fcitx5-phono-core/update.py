#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Pin the current Phono core main commit and unpacked source hash. Requires Nix."""

import argparse
import json
import re
import ssl
import subprocess
import sys
import tempfile
from datetime import datetime
from pathlib import Path
from urllib.request import Request, urlopen

import certifi

REPOSITORY = "phono-project/phono-core"
UPDATE_PATH = Path(__file__).resolve().with_name("update.json")


def fetch_text(url: str, context: ssl.SSLContext) -> str:
    request = Request(url, headers={"User-Agent": "nixos-fcitx5-phono-core-updater"})
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
    # Temporarily follow main; update.json pins the complete commit, not a branch URL.
    commit = fetch_json(
        f"https://api.github.com/repos/{REPOSITORY}/commits/main", context
    )
    revision = commit["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError(f"Unexpected core revision: {revision!r}")
    version = fetch_text(
        f"https://raw.githubusercontent.com/{REPOSITORY}/{revision}/VERSION.txt",
        context,
    ).strip()
    if not re.fullmatch(r"\d+\.\d+\.\d+", version):
        raise ValueError(f"Unexpected core version: {version!r}")
    date = datetime.fromisoformat(commit["commit"]["committer"]["date"]).date()
    return {
        "version": f"{version}-unstable-{date}",
        "revision": revision,
        **github_source(REPOSITORY, revision),
    }


def write_if_changed(path: Path, sources: dict, *, check: bool = False) -> bool:
    """Write atomically only after all downloads succeed; --check never writes."""
    content = json.dumps(sources, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False
    if not check:
        with tempfile.TemporaryDirectory(
            prefix=".fcitx5-phono-core-update-", dir=path.parent
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
        print(f"Failed to update Phono core source: {error}", file=sys.stderr)
        return 1

    if changed and args.check:
        print("update.json is out of date, rerun without --check", file=sys.stderr)
        return 1
    if changed:
        print(f"Updated {UPDATE_PATH}")
    else:
        print("Phono core source is already up to date")
    return 0


if __name__ == "__main__":
    sys.exit(main())
