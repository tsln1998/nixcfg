{ pkgs, ... }:
let
  repo = pkgs.unstable;
in
{
  programs.vscode = {
    enable = true;
    package = repo.vscode;
    extensions = with repo.vscode-extensions; [
      k--kato.intellij-idea-keybindings
      github.github-vscode-theme
      pkief.material-icon-theme
      editorconfig.editorconfig
      waderyan.gitblame
      codezombiech.gitignore
      gruntfuggly.todo-tree
      jnoortheen.nix-ide
      usernamehw.errorlens
    ];

    mutableExtensionsDir = false;
  };
}
