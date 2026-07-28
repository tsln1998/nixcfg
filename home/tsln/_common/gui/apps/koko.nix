{ pkgs, ... }: {
  home.packages = [
    pkgs.kdePackages.koko
  ];
}
