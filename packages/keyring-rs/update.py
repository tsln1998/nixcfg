#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update update.json from the latest published keyring-rs release."""

import argparse
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


REPOSITORY = "tsln1998/keyring-rs"
UPDATE_PATH = Path(__file__).resolve().with_name("update.json")
PLATFORM_SUFFIXES = {
    "x86_64-linux": "linux-x86_64",
    "aarch64-linux": "linux-arm64",
    "x86_64-darwin": "darwin-x86_64",
    "aarch64-darwin": "darwin-arm64",
}


class PlatformSource(TypedDict):
    url: str
    hash: str


class ReleaseHashes(TypedDict):
    version: str
    platforms: dict[str, PlatformSource]


def fetch_bytes(url: str, context: ssl.SSLContext) -> bytes:
    request = Request(url, headers={"User-Agent": "nixos-keyring-rs-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        return response.read()


def parse_checksums(contents: str) -> dict[str, str]:
    checksums: dict[str, str] = {}
    for line in contents.splitlines():
        if not line.strip():
            continue
        checksum, filename = line.split()
        filename = filename.removeprefix("*").removeprefix("./")
        if filename in checksums:
            raise ValueError(f"Duplicate checksum for {filename}")
        checksums[filename] = checksum
    return checksums


def checksum_to_sri(checksum: str) -> str:
    if not re.fullmatch(r"[0-9a-fA-F]{64}", checksum):
        raise ValueError(f"Invalid SHA-256 checksum: {checksum!r}")
    digest = base64.b64encode(bytes.fromhex(checksum)).decode("ascii")
    return f"sha256-{digest}"


def fetch_latest_hashes(*, include_prereleases: bool = False) -> ReleaseHashes:
    context = ssl.create_default_context(cafile=certifi.where())
    api_url = f"https://api.github.com/repos/{REPOSITORY}/releases"
    if include_prereleases:
        releases = json.loads(fetch_bytes(f"{api_url}?per_page=100", context))
        release = max(
            (release for release in releases if not release["draft"]),
            key=lambda release: release["published_at"],
            default=None,
        )
        if release is None:
            raise ValueError("No published keyring-rs releases found")
    else:
        release = json.loads(fetch_bytes(f"{api_url}/latest", context))

    tag = release["tag_name"]
    if release["draft"] or (release["prerelease"] and not include_prereleases):
        raise ValueError(f"Unexpected release: {tag!r}")
    if not re.fullmatch(
        r"v\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?", tag
    ):
        raise ValueError(f"Unexpected release tag: {tag!r}")

    asset_urls = {
        asset["name"]: asset["browser_download_url"] for asset in release["assets"]
    }
    checksums = parse_checksums(
        fetch_bytes(asset_urls["SHA256SUMS"], context).decode("utf-8")
    )
    platforms: dict[str, PlatformSource] = {}
    for system, suffix in PLATFORM_SUFFIXES.items():
        filename = f"keyring-rs-{tag}-{suffix}.tar.gz"
        platforms[system] = {
            "url": asset_urls[filename],
            "hash": checksum_to_sri(checksums[filename]),
        }
    return {"version": tag.removeprefix("v"), "platforms": platforms}


def write_hashes_if_changed(
    path: Path, hashes: ReleaseHashes, *, check: bool = False
) -> bool:
    content = json.dumps(hashes, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False
    if not check:
        with tempfile.TemporaryDirectory(
            prefix=".keyring-rs-update-", dir=path.parent
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
    parser.add_argument(
        "--pre",
        action="store_true",
        help="include prereleases when selecting the latest release",
    )
    args = parser.parse_args()
    try:
        hashes = fetch_latest_hashes(include_prereleases=args.pre)
        changed = write_hashes_if_changed(UPDATE_PATH, hashes, check=args.check)
    except (OSError, ValueError, KeyError, TypeError) as error:
        print(f"Failed to update keyring-rs hashes: {error}", file=sys.stderr)
        return 1

    if changed and args.check:
        print("update.json is out of date, rerun without --check", file=sys.stderr)
        return 1
    if changed:
        print(f"Updated {UPDATE_PATH} to keyring-rs {hashes['version']}")
    else:
        print(f"keyring-rs {hashes['version']} is already up to date")
    return 0


if __name__ == "__main__":
    sys.exit(main())
