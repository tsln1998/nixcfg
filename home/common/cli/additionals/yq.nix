{
  pkgs,
  ...
}:
{
  # install yq
  home.packages = [
    pkgs.yq-go
  ];
}
