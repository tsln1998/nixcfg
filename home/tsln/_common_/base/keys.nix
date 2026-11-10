{
  config,
  tools,
  lib,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;

  publicKeys = import (relative "secrets/agenix-keys.nix");
  authorizedKeys = import (relative "secrets/authorized-keys.nix");
in
{
  age.secrets =
    # Private Keys
    let
      file = relative "secrets/users/${username}/id_ed25519.age";
    in
    lib.optionalAttrs (builtins.pathExists file) {
      "users/${username}/id_ed25519" = {
        inherit file;

        path = "${homeDirectory}/.ssh/id_ed25519";
        mode = "600";
        symlink = false;
      };
    };

  home.file = {
    # Public Keys
    ".ssh/id_ed25519.pub" = {
      text = lib.lists.head (
        # generate public key
        lib.optionals (publicKeys ? users.${username}) publicKeys.users.${username}
      );
    };
  };

  home.activation.authorizedKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    # Authorized Keys
    lib.strings.concatStringsSep "\n" (
      [
        "run mkdir -p -m 700 $HOME/.ssh"
        "run rm -f $HOME/.ssh/authorized_keys"
        "run umask 077"
      ]
      ++ (map (key: "run echo ${lib.strings.escapeShellArg key} >> $HOME/.ssh/authorized_keys") (
        lib.optionals (authorizedKeys ? users.${username}) authorizedKeys.users.${username}
      ))
    )
  );
}
