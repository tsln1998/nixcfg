{
  pkgs,
  ...
}:
{
  # install yq
  home.packages = [
    pkgs.jq
    pkgs.yq-go
  ];
}
