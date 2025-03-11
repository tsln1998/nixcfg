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

  environment.shellAliases.nx = "nh";
  environment.shellAliases.nv = "nvd";
}
