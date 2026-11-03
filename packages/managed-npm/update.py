#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update pi package versions in update.json from the npm registry."""

import argparse
import json
import re
import ssl
import sys
import tempfile
from pathlib import Path
from typing import TypedDict
from urllib.parse import quote
from urllib.request import Request, urlopen

import certifi


UPDATE_PATH = Path(__file__).resolve().with_name("update.json")
NPM_LATEST_URL = "https://registry.npmjs.org/{name}/latest"


class Extension(TypedDict):
    name: str
    version: str


def fetch_json(url: str, context: ssl.SSLContext) -> dict:
    request = Request(url, headers={"User-Agent": "nixos-managed-npm-updater"})
    with urlopen(request, timeout=30, context=context) as response:
        return json.loads(response.read())


def version_key(version: str) -> tuple[int, int, int] | None:
    match = re.match(r"^(\d+)\.(\d+)\.(\d+)$", version)
    return tuple(int(part) for part in match.groups()) if match else None


def latest_version(name: str, context: ssl.SSLContext) -> str:
    # Scoped packages need the scope separator escaped: @scope%2Fname.
    payload = fetch_json(NPM_LATEST_URL.format(name=quote(name, safe="@")), context)
    return payload["version"]


def write_extensions(extensions: dict[str, Extension]) -> None:
    """Replace the JSON atomically so a failed run never leaves it half written."""
    content = json.dumps(extensions, indent=2, sort_keys=True) + "\n"
    with tempfile.TemporaryDirectory(
        prefix=".managed-npm-update-", dir=UPDATE_PATH.parent
    ) as directory:
        temporary_path = Path(directory) / UPDATE_PATH.name
        temporary_path.write_text(content, encoding="utf-8")
        temporary_path.replace(UPDATE_PATH)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="report pending updates without writing update.json",
    )
    args = parser.parse_args()

    context = ssl.create_default_context(cafile=certifi.where())
    extensions: dict[str, Extension] = json.loads(
        UPDATE_PATH.read_text(encoding="utf-8")
    )

    changed = False
    failures = 0

    for key, extension in extensions.items():
        try:
            latest = latest_version(extension["name"], context)
            current = extension["version"]
            if latest == current:
                print(f"{key}: {current} is up to date")
                continue

            latest_key = version_key(latest)
            current_key = version_key(current)
            if latest_key is None or (
                current_key is not None and latest_key <= current_key
            ):
                print(f"{key}: keeping {current} (registry only offers {latest})")
                continue

            print(f"{key}: {current} -> {latest}")
            extension["version"] = latest
            changed = True
        except (OSError, ValueError, KeyError, TypeError) as error:
            failures += 1
            print(f"{key}: failed: {error}", file=sys.stderr)

    if changed and not args.check:
        write_extensions(extensions)

    if changed and args.check:
        print("update.json is out of date, rerun without --check", file=sys.stderr)
    return 1 if (failures or (changed and args.check)) else 0


if __name__ == "__main__":
    sys.exit(main())
