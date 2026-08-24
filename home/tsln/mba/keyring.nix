{
  config,
  inputs,
  tools,
  ...
}:
let
  inherit (config.home) username homeDirectory;

  secretName = "users/${username}/keyring-rs/config.toml";
  socketPath = "${homeDirectory}/Library/Application Support/keyring-rs/keyring.sock";
in
{
  imports = [
    inputs.keyring-rs.homeModules.keyring-rs
  ];

  age.secrets."${secretName}" = {
    file = tools.relative "secrets/${secretName}.age";
    mode = "600";
  };

  services.keyring-rs = {
    enable = true;
    path = socketPath;
    settingsFile = config.age.secrets."${secretName}".path;
  };

  sshAuthSock.initialization = {
    bash = ''export SSH_AUTH_SOCK="${socketPath}"'';
    fish = ''set -x SSH_AUTH_SOCK "${socketPath}"'';
    nushell = ''$env.SSH_AUTH_SOCK = "${socketPath}"'';
  };
}
