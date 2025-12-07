{ config, lib, ... }:
let
  inherit (config.home) username;
  inherit (config.age) secrets;

  installKey =
    keyType:
    let
      privKeyPath = "users/${username}/id_${keyType}";
      pubKeyPath = "users/${username}/id_${keyType}.pub";
    in
    lib.concatStringsSep "\n" [
      (lib.optionalString (lib.hasAttr privKeyPath secrets) ''
        run install -m 0600 ${(builtins.getAttr privKeyPath secrets).path} $HOME/.ssh/id_${keyType}
      '')
      (lib.optionalString (lib.hasAttr pubKeyPath secrets) ''
        run install -m 0644 ${(builtins.getAttr pubKeyPath secrets).path} $HOME/.ssh/id_${keyType}.pub
        run cat $HOME/.ssh/id_${keyType}.pub >> $HOME/.ssh/authorized_keys
      '')
    ];
in
{
  # Install secret keys to ~/.ssh
  home.activation.secretKeys = lib.hm.dag.entryAfter [ "agenix" ] ''
    run mkdir -p $HOME/.ssh
    run rm -f $HOME/.ssh/id_* 2>/dev/null || true
    run rm -f $HOME/.ssh/authorized_keys 2>/dev/null || true
    ${(installKey "ed25519")}
    ${(installKey "rsa")}
    ${(installKey "dsa")}
    ${(installKey "ecdsa")}
    run chmod 0600 $HOME/.ssh/authorized_keys 2>/dev/null || true
  '';

  # Install git (pull configuration from remote repositories)
  programs.git = {
    enable = lib.mkDefault true;
  };
}
