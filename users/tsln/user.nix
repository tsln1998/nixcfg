{
  lib,
  pkgs,
  tools,
  config,
  ...
}:
let
  inherit (config.networking) hostName;

  username = "tsln";
  groups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
    "wheel"
    "docker"
    "networkmanager"
  ];
in
{
  # User configuration
  users.users = {
    "${username}" = {
      shell = pkgs.zsh;
      packages = [ pkgs.home-manager ];
      isNormalUser = true;
      extraGroups = groups;
      hashedPassword = "$2b$05$3FgVPgolxWAkfcAyKLMs3.acSQHMnQU6wUMylrJ.ypv/dEe8P62u2";
    };
  };

  # Home Manager configuration
  home-manager.users = lib.optionalAttrs config.services.comin.enable {
    "${username}" = tools.relative "home/${username}/${hostName}";
  };
}
