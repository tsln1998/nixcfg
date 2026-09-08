#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update Catppuccin sources to their default branches' latest commits.

Add repositories to REPOSITORIES to track more packages. Requires Nix on PATH.
"""

import json
import re
import ssl
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import TypedDict
from urllib.request import Request, urlopen

import certifi


HASHES_PATH = Path(__file__).resolve().with_name("hashes.json")
REPOSITORIES = {
    "konsole": "catppuccin/konsole",
}


class SourceHashes(TypedDict):
    version: str
    rev: str
    url: str
    hash: str


def prefetch_source_hash(url: str) -> str:
    """Hash the unpacked source tree, matching fetchzip's recursive hash."""
    result = subprocess.run(
        [
            "nix", "store", "prefetch-file",
            "--json", "--unpack", "--hash-type", "sha256", "--name", "source",
            url,
        ],
        check=True,
        stdout=subprocess.PIPE,
        text=True,
        timeout=180,
    )
    return json.loads(result.stdout)["hash"]


def fetch_repository_hashes(repository: str, context: ssl.SSLContext) -> SourceHashes:
    api_url = f"https://api.github.com/repos/{repository}/commits/HEAD"
    request = Request(api_url, headers={"User-Agent": "nixos-catppuccin-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        commit = json.load(response)

    revision = commit["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError(f"Invalid commit for {repository}: {revision!r}")

    url = f"https://github.com/{repository}/archive/{revision}.tar.gz"
    return {
        "version": revision[:6],
        "rev": revision,
        "url": url,
        "hash": prefetch_source_hash(url),
    }


def fetch_latest_hashes(path: Path) -> dict[str, SourceHashes]:
    """Refresh registered packages while preserving other top-level entries."""
    hashes = json.loads(path.read_text(encoding="utf-8")) if path.exists() else {}
    if not isinstance(hashes, dict):
        raise ValueError("Expected a JSON object keyed by package name")

    context = ssl.create_default_context(cafile=certifi.where())
    for name, repository in REPOSITORIES.items():
        hashes[name] = fetch_repository_hashes(repository, context)
    return hashes


def write_hashes_if_changed(path: Path, hashes: dict[str, SourceHashes]) -> bool:
    """Write all package updates atomically once every fetch has succeeded."""
    content = json.dumps(hashes, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False

    with tempfile.TemporaryDirectory(
        prefix=".catppuccin-update-", dir=path.parent
    ) as directory:
        temporary_path = Path(directory) / path.name
        temporary_path.write_text(content, encoding="utf-8")
        temporary_path.replace(path)
    return True


def main() -> int:
    try:
        hashes = fetch_latest_hashes(HASHES_PATH)
        changed = write_hashes_if_changed(HASHES_PATH, hashes)
    except (OSError, ValueError, KeyError, TypeError, subprocess.SubprocessError) as error:
        print(f"Failed to update Catppuccin hashes: {error}", file=sys.stderr)
        return 1

    if changed:
        print(f"Updated {HASHES_PATH}")
    else:
        print("Catppuccin hashes are already up to date")
    return 0


if __name__ == "__main__":
    sys.exit(main())
