{ lib, pkgs, ... }:
let
  repo = pkgs.unstable;
  vscodeWithWaylandIME = repo.vscode.overrideAttrs (oldAttrs: {
    postFixup = (oldAttrs.postFixup or "") + ''
      wrapProgram $out/bin/code \
        --add-flags "--enable-wayland-ime" \
        --add-flags "--enable-features=UseOzonePlatform" \
        --add-flags "--ozone-platform=wayland"
    '';
  });
in
{
  programs.vscode = {
    enable = true;
    package = vscodeWithWaylandIME;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with repo.vscode-extensions; [
        # Keybindings
        k--kato.intellij-idea-keybindings
        # Themes
        github.github-vscode-theme
        pkief.material-icon-theme
        # Common
        editorconfig.editorconfig
        waderyan.gitblame
        codezombiech.gitignore
        gruntfuggly.todo-tree
        usernamehw.errorlens
        # Nix
        jnoortheen.nix-ide
        # Golang
        golang.go
      ];

      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.autoDetectColorScheme" = true;
        "window.commandCenter" = false;
        "window.openFilesInNewWindow" = "off";
        "window.openFoldersInNewWindow" = "on";

        "workbench.startupEditor" = "none";
        "workbench.iconTheme" = lib.mkDefault "material-icon-theme";
        "workbench.preferredDarkColorTheme" = lib.mkDefault "GitHub Dark";
        "workbench.preferredLightColorTheme" = lib.mkDefault "GitHub Light";

        "chat.disableAIFeatures"= true;

        "security.workspace.trust.enabled" = false;

        "files.autoSaveWhenNoErrors" = true;
        "files.autoSaveWorkspaceFilesOnly" = true;
        "files.eol" = "\n";

        "editor.fontLigatures" = true;
        "editor.fontFamily" = "'Jetbrains Mono', 'Fira Code', 'Ubuntu Mono', 'Noto Sans CJK SC', 'Noto Serif CJK SC'";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorBlinking" = "phase";
        "editor.inlineSuggest.enabled" = true;
        "editor.acceptSuggestionOnCommitCharacter" = false;
        "editor.guides.bracketPairs" = true;
        "editor.largeFileOptimizations" = false;
        "editor.inlineSuggest.showToolbar" = "always";
        "editor.minimap.autohide" = "scroll";

        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.cursorStyleInactive" = "underline";

        "explorer.autoReveal" = true;
        "explorer.autoRevealExclude" = {
          "**/node_modules" = true;
        };

        "git.autofetch" = true;
        "git.fetchOnPull" = true;
        "git.enableSmartCommit" = true;

        "gitblame.delayBlame" = 500;
        "gitblame.ignoreWhitespace" = true;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
      };
    };
  };
}
