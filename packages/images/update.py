#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["certifi"]
# ///
"""Update Docker image tags in update.json from their registries."""

import argparse
import json
import re
import ssl
import sys
import tempfile
from pathlib import Path
from typing import TypedDict
from urllib.request import Request, urlopen

import certifi


UPDATE_PATH = Path(__file__).resolve().with_name("update.json")
DOCKER_HUB_TAGS_URL = "https://hub.docker.com/v2/repositories/{repo}/tags?page_size=100"
GHCR_TOKEN_URL = "https://ghcr.io/token?scope=repository:{repo}:pull"
GHCR_TAGS_URL = "https://ghcr.io/v2/{repo}/tags/list?n=1000"
UNSTABLE_MARKERS = ("alpha", "beta", "rc", "dev", "test", "snapshot")


class Image(TypedDict):
    repo: str
    tag: str
    tag_prefix: str


def fetch_json(url: str, context: ssl.SSLContext, token: str = "") -> dict:
    headers = {"User-Agent": "nixos-images-updater"}
    if token:
        headers["Authorization"] = f"Bearer {token}"

    with urlopen(Request(url, headers=headers), timeout=30, context=context) as response:
        return json.loads(response.read())


def split_registry(repo: str) -> tuple[str, str]:
    """Split "registry/namespace/name" into registry and path; default Docker Hub."""
    first, _, rest = repo.partition("/")
    if "." in first or ":" in first:
        return first, rest
    return "docker.io", repo


def list_tags(repo: str, context: ssl.SSLContext) -> list[str]:
    registry, path = split_registry(repo)

    if registry == "docker.io":
        # shortcut: only the 100 newest Docker Hub tags, enough for our repos;
        # paginate if a repo ever publishes more tags per release line.
        payload = fetch_json(DOCKER_HUB_TAGS_URL.format(repo=path), context)
        return [result["name"] for result in payload["results"]]

    if registry == "ghcr.io":
        token = fetch_json(GHCR_TOKEN_URL.format(repo=path), context)["token"]
        # shortcut: single page of 1000 GHCR tags, no Link-header pagination.
        payload = fetch_json(GHCR_TAGS_URL.format(repo=path), context, token)
        return payload["tags"] or []

    raise ValueError(f"unsupported registry: {registry}")


def version_key(tag: str, prefix: str) -> tuple[int, ...] | None:
    """Turn a tag into comparable integers, e.g. slim-2026.7.1377.0-2.12.0."""
    if not tag.startswith(prefix):
        return None

    rest = tag[len(prefix) :]
    if not rest or re.search(r"[^0-9.-]", rest):
        return None

    parts = [int(part) for part in re.split(r"[.-]", rest) if part]
    return tuple(parts) or None


def newest_tag(tags: list[str], image: Image) -> str | None:
    prefix = image.get("tag_prefix", "")
    candidates = []

    for tag in tags:
        if any(marker in tag.lower() for marker in UNSTABLE_MARKERS):
            continue

        key = version_key(tag, prefix)
        if key is not None:
            candidates.append((key, tag))

    return max(candidates)[1] if candidates else None


def write_images(images: dict[str, Image]) -> None:
    """Replace the JSON atomically so a failed run never leaves it half written."""
    content = json.dumps(images, indent=2, sort_keys=True) + "\n"
    with tempfile.TemporaryDirectory(
        prefix=".images-update-", dir=UPDATE_PATH.parent
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
    images: dict[str, Image] = json.loads(UPDATE_PATH.read_text(encoding="utf-8"))

    changed = False
    failures = 0

    for name, image in images.items():
        try:
            latest = newest_tag(list_tags(image["repo"], context), image)
            if latest is None:
                raise ValueError("no tag matches tag_prefix")

            current = image["tag"]
            if latest == current:
                print(f"{name}: {current} is up to date")
                continue

            current_key = version_key(current, image.get("tag_prefix", ""))
            if current_key is not None and version_key(latest, image.get("tag_prefix", "")) <= current_key:
                print(f"{name}: keeping {current} (registry only offers {latest})")
                continue

            print(f"{name}: {current} -> {latest}")
            image["tag"] = latest
            changed = True
        except (OSError, ValueError, KeyError, TypeError) as error:
            failures += 1
            print(f"{name}: failed: {error}", file=sys.stderr)

    if changed and not args.check:
        write_images(images)

    if changed and args.check:
        print("update.json is out of date, rerun without --check", file=sys.stderr)
    return 1 if (failures or (changed and args.check)) else 0


if __name__ == "__main__":
    sys.exit(main())
