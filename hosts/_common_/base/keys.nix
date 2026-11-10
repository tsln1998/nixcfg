{
  config,
  tools,
  lib,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;

  publicKeys = import (relative "secrets/agenix-keys.nix");
  authorizedKeys = import (relative "secrets/authorized-keys.nix");
in
{
  age.secrets =
    # Private Keys
    let
      file = relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.age";
    in
    lib.optionalAttrs (builtins.pathExists file) {
      "hosts/${hostName}/ssh_host_ed25519_key" = {
        inherit file;

        path = "/etc/ssh/keys/ssh_host_ed25519_key";
        symlink = false;
        mode = "0600";
      };
    };

  environment.etc =
    # Public Keys
    (lib.optionalAttrs (publicKeys ? hosts.${hostName}) {
      "ssh/keys/ssh_host_ed25519_key.pub" = {
        mode = "0644";
        text = lib.lists.head (
          # generate public key
          lib.optionals (publicKeys ? hosts.${hostName}) publicKeys.hosts.${hostName}
        );
      };
    })
    # Authorized Keys
    // (lib.optionalAttrs (authorizedKeys ? hosts.${hostName}) {
      "ssh/keys/authorized_keys" = {
        mode = "0644";
        text = lib.strings.concatStringsSep "\n" (
          # generate authorized_keys
          lib.optionals (authorizedKeys ? hosts.${hostName}) authorizedKeys.hosts.${hostName}
        );
      };
    });
}
