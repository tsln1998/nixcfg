{ pkgs, tools, ... }:
{
  imports = [
    (tools.relative "hosts/_common/services/openssh.nix")
  ];

  environment.systemPackages = [
    pkgs.ghostty.terminfo
  ];
}
