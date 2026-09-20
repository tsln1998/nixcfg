{ lib, ... }:
_: prev: {
  rtk = if lib.versionOlder prev.rtk.version "0.48.0" then prev.repos.unstable.rtk else prev.rtk;
}
