{ pkgs, ... }: {
  home.packages = [
    pkgs.repos.unstable.gitcomet
  ];
}
