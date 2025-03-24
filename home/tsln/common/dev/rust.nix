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

  home.sessionVariables = {
    # for rust-analyzer
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  home.sessionPath = [
    # for cargo install
    "${homeDirectory}/.cargo/bin"
  ];
}
