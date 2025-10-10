{
  tools,
  pkgs,
  config,
  ...
}:
let
  inherit (config.networking) hostName;
  inherit (config.age) secrets;

  username = "tsln";
  groups = [
    "wheel"
    "docker"
    "networkmanager"
  ];
in
{
  # User configuration
  users.users."${username}" = {
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
    extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) groups;
    isNormalUser = true;
    hashedPasswordFile = secrets."users/${username}/passwd".path;
  };

  # Home Manager configuration
  home-manager.users."${username}" = tools.relative "home/${username}/${hostName}";
}
