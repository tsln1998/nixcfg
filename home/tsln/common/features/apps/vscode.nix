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

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    userSettings = {
      "window.titleBarStyle" = "custom";
      "window.autoDetectColorScheme" = true;
      "workbench.preferredDarkColorTheme" = "GitHub Dark";
      "workbench.preferredLightColorTheme" = "GitHub Light";
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "'Fira Code', 'Ubuntu Mono', 'Noto Sans CJK SC', 'Noto Serif CJK SC'";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.formatterPath" = "nixfmt";
    };
  };
}
