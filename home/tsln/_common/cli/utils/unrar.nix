{
  pkgs,
  ...
}:
{
  # install unrar
  home.packages = [
    pkgs.unrar
  ];
}
