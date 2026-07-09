{
  pkgs,
  tools,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  inherit (tools) relative;
  inherit (config.home) username;
in
{
  # Secrets
  age.secrets."users/${username}/nix/nix.conf" = {
    file = relative "secrets/users/${username}/nix/nix.conf.age";
    mode = "600";
  };

  # Install nh and set flake path
  programs.nh = {
    enable = true;
    flake = if isLinux then "/etc/nixos" else null;
  };

  # Install access-tokens to ~/.config/nix/nix.conf
  nix.extraOptions = ''
    !include ${config.age.secrets."users/${username}/nix/nix.conf".path}
  '';
}
