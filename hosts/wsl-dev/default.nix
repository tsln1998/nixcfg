{ pkgs, ...}: {
  imports = [
    ../../modules/base/core
    ../../modules/base/server
    ../../modules/devel/core
    ../../modules/devel/nix
    ../../modules/devel/go
    ../../modules/shells
    ../../modules/utils
  ];

  system.stateVersion = "24.05";
}
