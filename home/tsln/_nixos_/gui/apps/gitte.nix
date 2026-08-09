{ pkgs, ... }: {
  home.packages = [
    pkgs.repos.unstable.gitte
  ];
}
