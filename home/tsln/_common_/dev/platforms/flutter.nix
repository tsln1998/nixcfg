{ pkgs, ... }: {
  home.packages = [
    pkgs.flutter
    pkgs.virtualgl
  ];
}
