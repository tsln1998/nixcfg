{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.jq
    pkgs.yq-go
  ];
}
