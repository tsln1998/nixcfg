{ lib, ... }:
_: prev: {
  pi-coding-agent =
    if lib.versionOlder prev.pi-coding-agent.version "0.86.1" then
      prev.repos.unstable.pi-coding-agent
    else
      prev.pi-coding-agent;
}
