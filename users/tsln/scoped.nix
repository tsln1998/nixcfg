{
  lib,
  tools,
  config,
  ...
}:
let
  inherit (config.networking) hostName;
  inherit (lib.strings) toLower;
  userName = "tsln";
in
{
  # Home Manager configuration
  home-manager.users = {
    "${userName}" = tools.relative "home/${userName}/${toLower hostName}";
  };
}
