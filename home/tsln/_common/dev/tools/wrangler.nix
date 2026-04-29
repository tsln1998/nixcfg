{ pkgs, ... }:
{
  home.packages = [
    pkgs.wrangler
    pkgs.worker-build
  ];
}
