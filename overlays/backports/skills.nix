{ lib, ... }:
_: prev: {
  skills = if lib.versionOlder prev.skills.version "1.6.0" then prev.repos.unstable.skills else prev.skills;
}
