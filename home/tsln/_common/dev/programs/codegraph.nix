{ pkgs, ... }:
{
  home.packages = [
    pkgs.codegraph
  ];

  programs.git = {
    ignores = [
      ".codegraph"
    ];
  };
}
