{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  environment.systemPackages = [ pkgs.nvd ];
}
