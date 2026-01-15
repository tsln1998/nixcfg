{ pkgs, ... }:
let
  repo = pkgs.unstable;
in
{
  programs.vscode.enable = true;
  programs.vscode.package = repo.vscode;
  programs.vscode.mutableExtensionsDir = false;
}
