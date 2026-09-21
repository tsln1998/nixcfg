{ lib, ... }:
_: prev: {
  pixi = if lib.versionOlder prev.pixi.version "0.80.0" then prev.repos.unstable.pixi else prev.pixi;
}
