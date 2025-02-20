{ config, ... }:
let
  inherit (config.home) username;
  inherit (config.age) secrets;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.file = {
    # ".ssh/id_rsa" = {
    #   source = mkOutOfStoreSymlink secrets."users/${username}/id_rsa".path;
    #   force = true;
    # };
    # ".ssh/id_rsa.pub" = {
    #   source = mkOutOfStoreSymlink secrets."users/${username}/id_rsa.pub".path;
    #   force = true;
    # };
    # ".ssh/id_ed25519" = {
    #   source =  secrets."users/${username}/id_ed25519".path;
    #   force = true;
    # };
    # ".ssh/id_ed25519.pub" = {
    #   source =  secrets."users/${username}/id_ed25519.pub".path;
    #   force = true;
    # };
  };

  home.activation._activation_dotssh_ = ''
    run mkdir -p $HOME/.ssh
    run ln -sf $VERBOSE_ARG ${secrets."users/${username}/id_rsa".path} $HOME/.ssh/id_rsa
    run ln -sf $VERBOSE_ARG ${secrets."users/${username}/id_rsa.pub".path} $HOME/.ssh/id_rsa.pub
    run ln -sf $VERBOSE_ARG ${secrets."users/${username}/id_ed25519".path} $HOME/.ssh/id_ed25519
    run ln -sf $VERBOSE_ARG ${secrets."users/${username}/id_ed25519.pub".path} $HOME/.ssh/id_ed25519.pub
  '';
}
