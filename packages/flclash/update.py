#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update the macOS FlClash sources from its stable GitHub release."""

import argparse
import base64
import json
import re
import ssl
import subprocess
import sys
import tempfile
from pathlib import Path
from urllib.request import Request, urlopen

import certifi

UPDATE_PATH = Path(__file__).resolve().with_name("update.json")
RELEASE_API_URL = "https://api.github.com/repos/chen08209/FlClash/releases/latest"
PLATFORM_TARGETS = {
    "aarch64-darwin": "macos-arm64.dmg",
    "x86_64-darwin": "macos-amd64.dmg",
}


def asset_hash(asset: dict) -> str:
    digest = asset.get("digest")
    if digest is not None:
        if not re.fullmatch(r"sha256:[0-9a-fA-F]{64}", digest):
            raise ValueError(f"Unexpected GitHub asset digest: {digest!r}")
        encoded = base64.b64encode(bytes.fromhex(digest.removeprefix("sha256:")))
        return f"sha256-{encoded.decode('ascii')}"
    result = subprocess.run(
        [
            "nix",
            "store",
            "prefetch-file",
            "--json",
            "--hash-type",
            "sha256",
            asset["browser_download_url"],
        ],
        check=True,
        stdout=subprocess.PIPE,
        text=True,
        timeout=600,
    )
    return json.loads(result.stdout)["hash"]


def fetch_latest_sources() -> dict:
    context = ssl.create_default_context(cafile=certifi.where())
    request = Request(RELEASE_API_URL, headers={"User-Agent": "nixos-flclash-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        release = json.load(response)
    if release["draft"] or release["prerelease"]:
        raise ValueError("Expected a stable FlClash release")
    tag = release["tag_name"]
    if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError(f"Unexpected FlClash release tag: {tag!r}")
    version = tag.removeprefix("v")
    assets = {asset["name"]: asset for asset in release["assets"]}
    platforms = {}
    for system, target in PLATFORM_TARGETS.items():
        asset = assets[f"FlClash-{version}-{target}"]
        platforms[system] = {
            "url": asset["browser_download_url"],
            "hash": asset_hash(asset),
        }
    return {"version": version, "platforms": platforms}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    try:
        sources = fetch_latest_sources()
        content = json.dumps(sources, indent=2, sort_keys=True) + "\n"
        if UPDATE_PATH.exists() and UPDATE_PATH.read_text(encoding="utf-8") == content:
            print("FlClash sources are already up to date")
            return 0
        if args.check:
            print("FlClash sources are out of date", file=sys.stderr)
            return 1
        with tempfile.TemporaryDirectory(
            prefix=".flclash-update-", dir=UPDATE_PATH.parent
        ) as directory:
            temporary_path = Path(directory) / UPDATE_PATH.name
            temporary_path.write_text(content, encoding="utf-8")
            temporary_path.replace(UPDATE_PATH)
    except (
        OSError,
        ValueError,
        KeyError,
        TypeError,
        subprocess.SubprocessError,
    ) as error:
        print(f"Failed to update FlClash sources: {error}", file=sys.stderr)
        return 1
    print(f"Updated {UPDATE_PATH} to FlClash {sources['version']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
