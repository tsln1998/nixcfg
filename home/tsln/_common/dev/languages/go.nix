{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go;
  };

  home.packages = [
    pkgs.go-tools
    pkgs.golangci-lint
    pkgs.delve
  ];
}
