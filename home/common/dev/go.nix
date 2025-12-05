{ pkgs, config, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  programs.go.enable = true;

  home.packages = with pkgs.unstable; [
    # for debugger
    gopls
    delve
  ];

  home.sessionPath = [
    # for go install
    "${homeDirectory}/go/bin"
  ];
}
