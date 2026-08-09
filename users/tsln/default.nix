{
  pkgs,
  lib,
  tools,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
  inherit (config.networking) hostName;
  inherit (lib.strings) toLower;
  userName = "tsln";
in
{
  # User configuration
  users.users."${userName}" =
    (lib.optionalAttrs isLinux {
      isNormalUser = true;
      linger = true;
      extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
        "wheel"
        "docker"
        "podman"
        "networkmanager"
      ];
      hashedPassword = "$2b$05$3FgVPgolxWAkfcAyKLMs3.acSQHMnQU6wUMylrJ.ypv/dEe8P62u2";
    })
    // (lib.optionalAttrs isDarwin {
      home = "/Users/${userName}";
    });

  # User primary
  system = lib.optionalAttrs isDarwin {
      primaryUser = lib.mkForce userName;
    };

  # Home Manager configuration
  home-manager.users = {
    "${userName}" = tools.relative "home/${userName}/${toLower hostName}";
  };
}
