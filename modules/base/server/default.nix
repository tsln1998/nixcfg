{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    htop
    lrzsz
  ];
}
