{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.repos.unstable.skills
  ];
}
