{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    wget
    smartmontools
  ];

  # for VSCode Server
  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld-rs;
}
