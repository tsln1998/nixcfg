{ pkgs, ... }:
let
  repo = pkgs.unstable;
in
{
  programs.chromium = {
    enable = true;
    package = repo.chromium;
  };
}
