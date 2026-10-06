{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  path = "${homeDirectory}/.cargo";
in
{
  home = {
    packages = with pkgs; [
      cargo
      rust-analyzer
      rustfmt
    ];

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      CARGO_HOME = lib.mkDefault path;
    };

    sessionPath = [
      "${path}/bin"
    ];
  };
}
