{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
  };
}
