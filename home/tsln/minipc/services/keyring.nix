{
  config,
  inputs,
  pkgs,
  tools,
  ...
}:
let
  inherit (config.home) username homeDirectory;

  secretName = "users/${username}/keyring/config.toml";
  SSH_AUTH_SOCK = "${homeDirectory}/.local/state/keyring/keyring.sock";
in
{
  imports = [
    inputs.keyring.homeModules.keyring-rs
  ];

  age.secrets."${secretName}" = {
    file = tools.relative "secrets/${secretName}.age";
    mode = "600";
  };

  services.keyring-rs = {
    enable = true;
    package = pkgs.repos.keyring;
    path = SSH_AUTH_SOCK;
    settingsFile = config.age.secrets."${secretName}".path;
  };

  systemd.user.services.keyring-rs.Unit = {
    After = [ "agenix.service" ];
    Wants = [ "agenix.service" ];
  };

  home.sessionVariables = {
    inherit SSH_AUTH_SOCK;
  };

  systemd.user.sessionVariables = {
    inherit SSH_AUTH_SOCK;
  };
}
