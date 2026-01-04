{lib, vscode-utils }:
let
  inherit (vscode-utils) buildVscodeMarketplaceExtension;
in
{
  bufbuild.vscode-buf = buildVscodeMarketplaceExtension {
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
  };
  ms-python.autopep8 = buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ms-python";
      name = "autopep8";
      version = "2025.2.0";
      hash = "sha256-N1ryz3MieHinTcm5d1RVbGApMQAUhrDUpxDUdfEDmvU=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/ms-python.autopep8/changelog";
      description = "Formatting support for Python files using the autopep8 formatter.";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=ms-python.autopep8";
      homepage = "https://github.com/microsoft/vscode-autopep8";
      license = lib.licenses.mit;
      maintainers = [ ];
    };
  };
}
