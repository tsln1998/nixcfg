{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    gopls
    gotests
    gomodifytags
    go-tools
    impl
  ];
}
