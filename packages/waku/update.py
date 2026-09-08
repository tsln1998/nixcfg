#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update hashes.json from the latest stable Waku release."""

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


RELEASE_API_URL = "https://api.github.com/repos/egoist/waku/releases/latest"
HASHES_PATH = Path(__file__).resolve().with_name("hashes.json")
PLATFORM_TARGETS = {
    "x86_64-linux": "x86_64-unknown-linux-gnu",
    "aarch64-linux": "aarch64-unknown-linux-gnu",
}


class PlatformSource(TypedDict):
    url: str
    hash: str


class ReleaseHashes(TypedDict):
    version: str
    platforms: dict[str, PlatformSource]


def digest_to_sri(digest: str) -> str:
    """Convert GitHub's sha256:<hex> asset digest to Nix's SRI format."""
    if not isinstance(digest, str) or not re.fullmatch(r"sha256:[0-9a-fA-F]{64}", digest):
        raise ValueError(f"Invalid SHA-256 asset digest: {digest!r}")

    checksum = bytes.fromhex(digest.removeprefix("sha256:"))
    encoded_checksum = base64.b64encode(checksum).decode("ascii")
    return f"sha256-{encoded_checksum}"


def fetch_latest_hashes() -> ReleaseHashes:
    context = ssl.create_default_context(cafile=certifi.where())
    request = Request(RELEASE_API_URL, headers={"User-Agent": "nixos-waku-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        release = json.load(response)

    tag = release["tag_name"]
    if release["draft"] or release["prerelease"]:
        raise ValueError(f"Expected a stable release, got {tag!r}")
    if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError(f"Unexpected Waku release tag: {tag!r}")

    version = tag.removeprefix("v")
    assets = {asset["name"]: asset for asset in release["assets"]}
    platforms: dict[str, PlatformSource] = {}
    for system, target in PLATFORM_TARGETS.items():
        filename = f"waku-{version}-{target}.tar.gz"
        asset = assets[filename]
        platforms[system] = {
            "url": asset["browser_download_url"],
            "hash": digest_to_sri(asset["digest"]),
        }

    return {"version": version, "platforms": platforms}


def write_hashes_if_changed(path: Path, hashes: ReleaseHashes) -> bool:
    """Replace the JSON atomically; return False if it is already identical."""
    content = json.dumps(hashes, indent=2, sort_keys=True) + "\n"
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return False

    with tempfile.TemporaryDirectory(prefix=".waku-update-", dir=path.parent) as directory:
        temporary_path = Path(directory) / path.name
        temporary_path.write_text(content, encoding="utf-8")
        temporary_path.replace(path)
    return True


def main() -> int:
    try:
        hashes = fetch_latest_hashes()
        changed = write_hashes_if_changed(HASHES_PATH, hashes)
    except (OSError, ValueError, KeyError, TypeError) as error:
        print(f"Failed to update Waku hashes: {error}", file=sys.stderr)
        return 1

    version = hashes["version"]
    if changed:
        print(f"Updated {HASHES_PATH} to Waku {version}")
    else:
        print(f"Waku {version} is already up to date")
    return 0


if __name__ == "__main__":
    sys.exit(main())
