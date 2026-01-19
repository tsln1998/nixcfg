{
  lib,
  tools,
  config,
  ...
}:
let
  inherit (config.networking) hostName;
  userName = "tsln";
in
{
  # User configuration
  users.users = {
    "${userName}" = {
      isNormalUser = true;
      extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
        "wheel"
        "docker"
        "networkmanager"
      ];
      hashedPassword = "$2b$05$3FgVPgolxWAkfcAyKLMs3.acSQHMnQU6wUMylrJ.ypv/dEe8P62u2";
    };
  };

  # Home Manager configuration
  home-manager.users = lib.optionalAttrs (config.services.comin.enable) {
    "${userName}" = tools.relative "home/${userName}/${hostName}";
  };
}
