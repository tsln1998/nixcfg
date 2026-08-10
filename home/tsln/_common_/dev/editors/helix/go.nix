{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [
      gopls
      golangci-lint
      golangci-lint-langserver
    ];

    languages.language-server.gopls.config = {
      gofumpt = true;
      staticcheck = true;
      usePlaceholders = true;
      analyses = {
        nilness = true;
        unusedparams = true;
        unusedwrite = true;
      };
    };
  };
}
