{ inputs, ... }:
final: prev:
let
  pkgs' = inputs.vscode.overlays.default final prev;
in
{
  vscode-extensions = prev.vscode-extensions // {
    openfga = (prev.vscode-extensions.openfga or { }) // {
      inherit (pkgs'.vscode-marketplace-release.openfga) openfga-vscode;
    };
    bufbuild = (prev.vscode-extensions.bufbuild or { }) // {
      inherit (pkgs'.vscode-marketplace-release.bufbuild) vscode-buf;
    };
    ms-python = (prev.vscode-extensions.ms-python or { }) // {
      inherit (pkgs'.vscode-marketplace-release.ms-python) autopep8;
    };
  };
}
