{
  config,
  inputs,
  tools,
  ...
}:
let
  inherit (config.home) username homeDirectory;

  secretName = "users/${username}/keyring-rs/config.toml";
  SSH_AUTH_SOCK = "${homeDirectory}/.local/state/keyring-rs/keyring.sock";
in
{
  imports = [
    inputs.keyring-rs.homeModules.keyring-rs
  ];

  age.secrets."users/${username}/keyring-rs/config.toml" = {
    file = tools.relative "secrets/${secretName}.age";
    mode = "600";
  };

  services.keyring-rs = {
    enable = true;
    path = SSH_AUTH_SOCK;
    settingsFile = config.age.secrets."users/${username}/keyring-rs/config.toml".path;
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
