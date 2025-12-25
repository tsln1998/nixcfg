{
  lib,
  tools,
  pkgs,
  ...
}:
let
  repo = pkgs.unstable;
in
rec {
  programs.vscode = {
    enable = true;
    package = repo.vscode;
    mutableExtensionsDir = false;

    profiles =
      let
        default = {
          extensions = with repo.vscode-extensions; [
            # Keybindings
            k--kato.intellij-idea-keybindings
            # Common
            editorconfig.editorconfig
            waderyan.gitblame
            codezombiech.gitignore
            gruntfuggly.todo-tree
            usernamehw.errorlens
            tamasfe.even-better-toml
          ];

          userSettings = {
            "window.titleBarStyle" = lib.mkForce "native";
            "window.menuStyle" = lib.mkForce "custom";
            "window.commandCenter" = lib.mkDefault false;
            "window.openFilesInNewWindow" = lib.mkDefault "off";
            "window.openFoldersInNewWindow" = lib.mkDefault "on";

            "workbench.startupEditor" = lib.mkDefault "none";

            "chat.disableAIFeatures" = lib.mkDefault true;

            "security.workspace.trust.enabled" = lib.mkDefault false;

            "files.autoSaveWhenNoErrors" = lib.mkDefault true;
            "files.autoSaveWorkspaceFilesOnly" = lib.mkDefault true;
            "files.eol" = lib.mkDefault "\n";

            "editor.fontLigatures" = lib.mkDefault true;
            "editor.fontFamily" = lib.mkDefault (
              lib.strings.concatStringsSep ", " [
                "'Fira Code'"
                "'Jetbrains Mono'"
                "'Ubuntu Mono'"
              ]
            );
            "editor.cursorSmoothCaretAnimation" = lib.mkDefault "on";
            "editor.cursorBlinking" = lib.mkDefault "phase";
            "editor.inlineSuggest.enabled" = lib.mkDefault true;
            "editor.acceptSuggestionOnCommitCharacter" = lib.mkDefault false;
            "editor.guides.bracketPairs" = lib.mkDefault true;
            "editor.largeFileOptimizations" = lib.mkDefault false;
            "editor.inlineSuggest.showToolbar" = lib.mkDefault "always";
            "editor.minimap.autohide" = lib.mkDefault "scroll";

            "terminal.integrated.cursorStyle" = lib.mkDefault "line";
            "terminal.integrated.cursorStyleInactive" = lib.mkDefault "underline";

            "explorer.autoReveal" = lib.mkDefault true;
            "explorer.autoRevealExclude" = lib.mkDefault {
              "**/node_modules" = lib.mkDefault true;
            };

            "git.autofetch" = lib.mkDefault true;
            "git.fetchOnPull" = lib.mkDefault true;
            "git.enableSmartCommit" = lib.mkDefault true;

            "gitblame.delayBlame" = lib.mkDefault 500;
            "gitblame.ignoreWhitespace" = lib.mkDefault true;
          };
        };
      in
      {
        default = tools.merge default {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
        };

        Go = tools.merge default {
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
            "nix.enableLanguageServer" = lib.mkDefault true;
            "nix.serverPath" = lib.mkDefault "nixd";
            "nix.formatterPath" = lib.mkDefault "nixfmt";
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

        Java = tools.merge default {
          extensions = with repo.vscode-extensions; [
            # Kotlin LSP
            mathiasfrohlich.kotlin
          ];

          userSettings = {
          };
        };
      };
  };

  catppuccin.vscode.profiles = lib.mapAttrs (_: _: {
    # enable color theme
    enable = true;
  }) programs.vscode.profiles;
}
