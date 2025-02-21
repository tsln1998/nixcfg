{ pkgs, ... }:
{
  security.sudo = {
    enable = true;
    package = pkgs.sudo;
    wheelNeedsPassword = false;
  };
}
