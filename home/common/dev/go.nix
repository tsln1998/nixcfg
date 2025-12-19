{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  repo = pkgs.unstable;
  path = "${homeDirectory}/.go";
in
{
  programs.go = {
    enable = true;
    package = repo.go;
  };

  # for debugger
  home.packages = with repo; [
    gopls
    delve
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
