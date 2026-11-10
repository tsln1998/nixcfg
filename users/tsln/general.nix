{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
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
      hashedPassword = "$y$j9T$7ZDX/Kx5J2vtL9GZV7q0s.$SM.SCMBXk7MCgfpRF5omWWOYPPeRq0qeaarLLNEBn5A";
    })
    // (lib.optionalAttrs isDarwin {
      home = "/Users/${userName}";
    });

  # User primary
  system = lib.optionalAttrs isDarwin {
    primaryUser = lib.mkForce userName;
  };
}
