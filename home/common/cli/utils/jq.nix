{
  pkgs,
  ...
}:
{
  # install jq
  home.packages = [
    pkgs.jq
  ];
}
