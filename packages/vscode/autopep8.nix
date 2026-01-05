{lib, vscode-utils }:
let
  inherit (vscode-utils) buildVscodeMarketplaceExtension;
in
buildVscodeMarketplaceExtension {
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
}
