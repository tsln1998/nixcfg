{ lib, ... }:
_: prev: {
  mcporter = if lib.versionOlder prev.mcporter.version "0.13.0" then prev.repos.unstable.mcporter else prev.mcporter;
}
