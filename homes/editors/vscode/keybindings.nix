{ pkgs, ... }: {
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    k--kato.intellij-idea-keybindings
  ];
}
