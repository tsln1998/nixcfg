{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.unstable.codegraph
  ];

  programs.git = {
    ignores = [
      ".codegraph"
    ];
  };
}
