#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update hashes.json from the latest stable native Codex release."""

import base64
import json
import re
import ssl
import sys
import tempfile
from pathlib import Path
from typing import TypedDict
from urllib.request import Request, urlopen

import certifi


RELEASE_API_URL = "https://api.github.com/repos/openai/codex/releases/latest"
CHECKSUM_ASSET_NAME = "codex-package_SHA256SUMS"
HASHES_PATH = Path(__file__).resolve().with_name("hashes.json")
PLATFORM_TARGETS = {
    "x86_64-linux": "x86_64-unknown-linux-musl",
    "aarch64-linux": "aarch64-unknown-linux-musl",
    "x86_64-darwin": "x86_64-apple-darwin",
    "aarch64-darwin": "aarch64-apple-darwin",
}


class PlatformSource(TypedDict):
    url: str
    hash: str


class ReleaseHashes(TypedDict):
    version: str
    platforms: dict[str, PlatformSource]


def fetch_bytes(url: str, context: ssl.SSLContext) -> bytes:
    request = Request(url, headers={"User-Agent": "nixos-codex-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        return response.read()


def parse_checksums(contents: str) -> dict[str, str]:
    """Read SHA256SUMS entries into a filename-to-checksum mapping."""
    checksums: dict[str, str] = {}
    for line in contents.splitlines():
        if not line.strip():
            continue

        checksum, filename = line.split()
        # sha256sum prefixes binary-mode filenames with an asterisk.
        filename = filename.removeprefix("*")
        if filename in checksums:
            raise ValueError(f"Duplicate checksum for {filename}")
        checksums[filename] = checksum

    return checksums


def checksum_to_sri(checksum: str) -> str:
    """Convert a hexadecimal SHA-256 checksum to Nix's SRI format."""
    if not re.fullmatch(r"[0-9a-fA-F]{64}", checksum):
        raise ValueError(f"Invalid SHA-256 checksum: {checksum!r}")

    digest = bytes.fromhex(checksum)
    encoded_digest = base64.b64encode(digest).decode("ascii")
    return f"sha256-{encoded_digest}"


def fetch_latest_hashes() -> ReleaseHashes:
    context = ssl.create_default_context(cafile=certifi.where())
    release = json.loads(fetch_bytes(RELEASE_API_URL, context))

    tag = release["tag_name"]
    if release["draft"] or release["prerelease"]:
        raise ValueError(f"Expected a stable release, got {tag!r}")
    if not re.fullmatch(r"rust-v\d+\.\d+\.\d+", tag):
        raise ValueError(f"Unexpected Rust release tag: {tag!r}")

    asset_urls = {
        asset["name"]: asset["browser_download_url"] for asset in release["assets"]
    }
    checksum_url = asset_urls[CHECKSUM_ASSET_NAME]
    checksum_contents = fetch_bytes(checksum_url, context).decode("utf-8")
    checksums = parse_checksums(checksum_contents)

    platforms: dict[str, PlatformSource] = {}
    for system, target in PLATFORM_TARGETS.items():
        filename = f"codex-package-{target}.tar.gz"
        platforms[system] = {
            "url": asset_urls[filename],
            "hash": checksum_to_sri(checksums[filename]),
        }

    return {"version": tag.removeprefix("rust-v"), "platforms": platforms}


def write_hashes_if_changed(path: Path, hashes: ReleaseHashes) -> bool:
    """Replace the JSON atomically; return False if it is already identical."""
    content = json.dumps(hashes, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False

    # Keep the temporary file on the same filesystem for an atomic replacement.
    with tempfile.TemporaryDirectory(prefix=".codex-update-", dir=path.parent) as directory:
        temporary_path = Path(directory) / path.name
        temporary_path.write_text(content, encoding="utf-8")
        temporary_path.replace(path)
    return True


def main() -> int:
    try:
        hashes = fetch_latest_hashes()
        changed = write_hashes_if_changed(HASHES_PATH, hashes)
    except (OSError, ValueError, KeyError, TypeError) as error:
        print(f"Failed to update Codex hashes: {error}", file=sys.stderr)
        return 1

    version = hashes["version"]
    if changed:
        print(f"Updated {HASHES_PATH} to Codex {version}")
    else:
        print(f"Codex {version} is already up to date")
    return 0


if __name__ == "__main__":
    sys.exit(main())
