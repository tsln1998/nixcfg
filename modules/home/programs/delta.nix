{ config, lib, ... }:
let
  cfg = config.programs.git;
in
{
  programs.delta = lib.optionalAttrs cfg.enable {
    enable = true;
    enableGitIntegration = true;
  };
}
