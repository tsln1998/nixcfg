{
  pkgs,
  ...
}:
{
  # install unzip
  home.packages = [
    pkgs.unzip
  ];
}
