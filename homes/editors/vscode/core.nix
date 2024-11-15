{ pkgs-unstable, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs-unstable.vscode-extensions; [
      k--kato.intellij-idea-keybindings
    ];
  };
}
