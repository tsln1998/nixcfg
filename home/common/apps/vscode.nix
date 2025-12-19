{ lib, tools, pkgs, ... }:
let
  repo = pkgs.unstable;
  package = repo.vscode.overrideAttrs (oldAttrs: {
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
    package = package;
    mutableExtensionsDir = false;

    profiles =
      let
        default = {
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
            tamasfe.even-better-toml
          ];

          userSettings = {
            "window.titleBarStyle" = "native";
            "window.menuStyle" = "custom";
            "window.autoDetectColorScheme" = true;
            "window.commandCenter" = false;
            "window.openFilesInNewWindow" = "off";
            "window.openFoldersInNewWindow" = "on";

            "workbench.startupEditor" = "none";
            "workbench.iconTheme" = lib.mkDefault "material-icon-theme";
            "workbench.preferredDarkColorTheme" = lib.mkDefault "GitHub Dark";
            "workbench.preferredLightColorTheme" = lib.mkDefault "GitHub Light";
            "workbench.layoutControl.enabled" = false;

            "chat.disableAIFeatures" = true;

            "security.workspace.trust.enabled" = false;

            "files.autoSaveWhenNoErrors" = true;
            "files.autoSaveWorkspaceFilesOnly" = true;
            "files.eol" = "\n";

            "editor.fontLigatures" = true;
            "editor.fontFamily" = lib.strings.concatStringsSep ", " [
              "'Jetbrains Mono'"
              "'Fira Code'"
              "'Ubuntu Mono'"
            ];
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
          };
        };
      in
      {
        default = tools.merge default {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
        };

        Go = tools.merge default{
          extensions = with repo.vscode-extensions; [
            # Golang
            golang.go
          ];
        };

        Nix = tools.merge default {
          extensions = with repo.vscode-extensions; [
            # Nix
            jnoortheen.nix-ide
          ];

          userSettings = {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.formatterPath" = "nixfmt";
          };
        };

        Rust = tools.merge default {
          extensions = with repo.vscode-extensions; [
            # Rust Analyzer
            rust-lang.rust-analyzer
          ];

          userSettings = {
          };
        };
      };
  };
}
