{ pkgs, ... }:
{
  environment.defaultPackages = [
    pkgs.nvd
  ];
}
