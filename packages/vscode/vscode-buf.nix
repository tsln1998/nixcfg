{lib, vscode-utils }:
let
  inherit (vscode-utils) buildVscodeMarketplaceExtension;
in
buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "bufbuild";
    name = "vscode-buf";
    version = "0.8.1";
    hash = "sha256-pJG1vrx5BmI+60rh+OkeVASDLQPQGNaeAYs/07Va438=";
  };
  meta = {
    changelog = "https://marketplace.visualstudio.com/items/bufbuild.vscode-buf/changelog";
    description = "Visual Studio Code support for Buf";
    downloadPage = "https://marketplace.visualstudio.com/items?itemName=bufbuild.vscode-buf";
    homepage = "https://github.com/nix-community/vscode-nix-ide";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
