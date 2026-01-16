{
  lib,
  pkgs,
  tools,
  config,
  ...
}:
let
  inherit (config.networking) hostName;
  inherit (config.age) secrets;

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
      hashedPasswordFile = secrets."users/${username}/passwd".path;
    };
  };

  # Home Manager configuration
  home-manager.users = lib.optionalAttrs config.services.comin.enable {
    "${username}" = tools.relative "home/${username}/${hostName}";
  };
}
