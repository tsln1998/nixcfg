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
  home.sessionVariables = {
    GOPATH = lib.mkDefault path;
    GOPROXY = "https://goproxy.cn,direct";
    GOSUMDB = "sum.golang.google.cn";
  };

  home.sessionPath = [
    "${path}/bin"
  ];
}
