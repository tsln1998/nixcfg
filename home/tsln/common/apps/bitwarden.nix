{ config, pkgs, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  home.packages = [
    pkgs.bitwarden-desktop
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "${homeDirectory}/.bitwarden-ssh-agent.sock";
  };
}
