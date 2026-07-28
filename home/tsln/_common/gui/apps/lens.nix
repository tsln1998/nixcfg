{ pkgs, ... }: {
  home.packages = [
    pkgs.repos.unstable.lens
  ];
}
