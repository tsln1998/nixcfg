{ pkgs, config, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  home.packages = with pkgs; [
    cargo
    rustc
    rustfmt
  ];

  # cargo environment variables
  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  # cargo paths
  home.sessionPath = [
    "${homeDirectory}/.cargo/bin"
  ];
}
