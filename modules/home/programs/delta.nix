{ config, lib, ... }:
let
  inherit (config.programs) git;
in
{
  programs.delta = lib.optionalAttrs git.enable {
    enable = lib.mkDefault true;
    enableGitIntegration = lib.mkDefault true;
  };
}
