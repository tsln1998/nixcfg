{ lib, ... }:
_: prev: {
  beads = if lib.versionOlder prev.beads.version "1.3.0" then prev.repos.unstable.beads else prev.beads;
}
