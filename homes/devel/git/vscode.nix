{ pkgs, ... }:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    codezombiech.gitignore
    waderyan.gitblame
  ];
}
