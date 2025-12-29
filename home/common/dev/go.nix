{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  path = "${homeDirectory}/.go";
in
{
  programs.go = {
    enable = true;
    package = pkgs.go;
  };

  # for debugger
  home.packages = [
    pkgs.go-tools
    pkgs.gopls
    pkgs.delve
  ];

  # go environment variables
  home.sessionVariables = {
    GOPATH = lib.mkDefault path;
  };

  # go paths
  home.sessionPath = [
    "${path}/bin"
  ];
}
