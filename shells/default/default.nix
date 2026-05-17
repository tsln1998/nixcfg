# An environment for nix develop
#
pkgs:
pkgs.mkShell {
  name = "default-devshell";
  packages = with pkgs; [
    nixd
    nixfmt
    nixfmt-tree
  ];
}
