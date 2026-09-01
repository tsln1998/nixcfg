{ pkgs, ... }: {
  home.packages = [
    pkgs.repos.local.pen
  ];
}
