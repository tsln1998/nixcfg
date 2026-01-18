{
  pkgs,
  ...
}:
{
  programs.go = {
    enable = true;
    package = pkgs.go;
  };

  # for debugger
  home.packages = [
    pkgs.go-tools
    pkgs.gopls
    pkgs.delve
  ];
}
