#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update the macOS Feishu sources from its official download API."""

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

UPDATE_PATH = Path(__file__).resolve().with_name("update.json")
DOWNLOAD_API_URL = "https://www.feishu.cn/api/downloads"
PLATFORM_TARGETS = {
    "aarch64-darwin": ("MacOS_m1", "arm64"),
    "x86_64-darwin": ("MacOS", "x64"),
}


def fetch_latest_sources() -> dict:
    context = ssl.create_default_context(cafile=certifi.where())
    request = Request(DOWNLOAD_API_URL, headers={"User-Agent": "nixos-feishu-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        versions = json.load(response)["versions"]

    platforms = {}
    release_versions = set()
    for system, (target, architecture) in PLATFORM_TARGETS.items():
        url = versions[target]["download_link"]
        match = re.search(
            rf"/Feishu-darwin_{architecture}-(\d+(?:\.\d+)+)-signed\.dmg$", url
        )
        if match is None:
            raise ValueError(f"Unexpected Feishu download URL: {url!r}")
        release_versions.add(match[1])
        result = subprocess.run(
            [
                "nix",
                "store",
                "prefetch-file",
                "--json",
                "--hash-type",
                "sha256",
                url,
            ],
            check=True,
            stdout=subprocess.PIPE,
            text=True,
            timeout=600,
        )
        platforms[system] = {"url": url, "hash": json.loads(result.stdout)["hash"]}

    if len(release_versions) != 1:
        raise ValueError(
            f"Feishu architectures have different versions: {release_versions}"
        )
    return {"version": release_versions.pop(), "platforms": platforms}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    try:
        sources = fetch_latest_sources()
        content = json.dumps(sources, indent=2, sort_keys=True) + "\n"
        if UPDATE_PATH.exists() and UPDATE_PATH.read_text(encoding="utf-8") == content:
            print("Feishu sources are already up to date")
            return 0
        if args.check:
            print("Feishu sources are out of date", file=sys.stderr)
            return 1
        with tempfile.TemporaryDirectory(
            prefix=".feishu-update-", dir=UPDATE_PATH.parent
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
        print(f"Failed to update Feishu sources: {error}", file=sys.stderr)
        return 1
    print(f"Updated {UPDATE_PATH} to Feishu {sources['version']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
