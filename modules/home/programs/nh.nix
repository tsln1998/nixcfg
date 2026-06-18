{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = lib.optionals config.programs.nh.enable [
    pkgs.nvd
  ];
}
