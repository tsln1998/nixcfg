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
  programs.go.env = {
    GOPATH = lib.mkDefault path;
    GOPROXY = "https://goproxy.cn,direct";
    GOSUMDB = "sum.golang.google.cn";
  };

  home.sessionPath = [
    "${path}/bin"
  ];
}
