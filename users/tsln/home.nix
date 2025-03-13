{
  tools,
  pkgs,
  config,
  ...
}:
let
  inherit (builtins) filter hasAttr;
  inherit (tools) relative;
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
  imports = (
    map relative [
      "<home-manager>"
      "users/common"
    ]
  );

  # User configuration
  users.users."${username}" = {
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
    extraGroups = filter (g: hasAttr g config.users.groups) groups;
    isNormalUser = true;
    hashedPasswordFile = secrets."users/${username}/passwd".path;
  };

  # Home Manager configuration
  home-manager.users."${username}" = relative "home/${username}/${hostName}";
}
