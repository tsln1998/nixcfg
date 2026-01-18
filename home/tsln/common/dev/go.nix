{
  lib,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  path = "${homeDirectory}/.go";
in
{
  # go environment variables
  home.sessionVariables = {
    GOPATH = lib.mkDefault path;
  };

  # go paths
  home.sessionPath = [
    "${path}/bin"
  ];
}
