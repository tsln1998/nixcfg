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
    GOPROXY = "https://goproxy.cn,direct";
    GOSUMDB = "sum.golang.google.cn";
  };

  # go paths
  home.sessionPath = [
    "${path}/bin"
  ];
}
