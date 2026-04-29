{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    rustc
    rustfmt

    lld

    cargo-workspaces
    cargo-generate
  ];
}
