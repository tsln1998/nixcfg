{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  GOPATH = "${homeDirectory}/.go";
in
{
  programs.go.enable = true;

  # for debugger
  home.packages = with pkgs.unstable; [
    gopls
    delve
  ];

  # go environment variables
  home.sessionVariables = {
    GOPATH = lib.mkDefault GOPATH;
  };

  # go paths
  home.sessionPath = [
    "${GOPATH}/bin"
  ];
}
