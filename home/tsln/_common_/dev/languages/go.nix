{
  lib,
  pkgs,
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

    env = {
      GOPATH = lib.mkDefault path;
      GOPROXY = "https://goproxy.cn,direct";
      GOSUMDB = "sum.golang.google.cn";
    };
  };

  home.packages = [
    pkgs.go-tools
    pkgs.golangci-lint
    pkgs.delve
  ];

  home.sessionPath = [
    "${path}/bin"
  ];
}
