{ config, lib, ... }:
let
  inherit (config.home) username;
  inherit (config.age) secrets;
in
{
  home.activation.secretKeys = lib.hm.dag.entryAfter [ "agenix" ] ''
    run mkdir -p $HOME/.ssh
    run rm -f $HOME/.ssh/config || true
    run cp $VERBOSE_ARG ${secrets."users/${username}/ssh_config".path} $HOME/.ssh/config
    run rm -f $HOME/.ssh/id_rsa || true
    run cp $VERBOSE_ARG ${secrets."users/${username}/id_rsa".path} $HOME/.ssh/id_rsa
    run rm -f $HOME/.ssh/id_rsa.pub || true
    run cp $VERBOSE_ARG ${secrets."users/${username}/id_rsa.pub".path} $HOME/.ssh/id_rsa.pub
    run rm -f $HOME/.ssh/id_ed25519 || true
    run cp $VERBOSE_ARG ${secrets."users/${username}/id_ed25519".path} $HOME/.ssh/id_ed25519
    run rm -f $HOME/.ssh/id_ed25519.pub || true
    run cp $VERBOSE_ARG ${secrets."users/${username}/id_ed25519.pub".path} $HOME/.ssh/id_ed25519.pub
    run cat $HOME/.ssh/id_rsa.pub $HOME/.ssh/id_ed25519.pub > $HOME/.ssh/authorized_keys
    run chmod 0600 $HOME/.ssh/authorized_keys
  '';
}
