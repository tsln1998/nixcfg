{ pkgs, ... }:
{
  imports = [
    ./openssh.nix
  ];

  environment.systemPackages = with pkgs; [
    htop
    lrzsz
  ];
}
