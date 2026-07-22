{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = [ pkgs.rust-analyzer ];

    languages.language-server.rust-analyzer.config = {
      cargo.allFeatures = true;
      check.command = "clippy";
      procMacro.enable = true;
    };
  };
}
