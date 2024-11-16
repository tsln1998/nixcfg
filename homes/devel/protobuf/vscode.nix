{ pkgs, ... }:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [ zxh404.vscode-proto3 ];
}
