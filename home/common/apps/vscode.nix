{
  lib,
  tools,
  pkgs,
  ...
}:
let
  repo = pkgs.unstable;
  preset = {
    extensions = with repo.vscode-extensions; [
      # Keybindings
      k--kato.intellij-idea-keybindings
      # Rainbow
      oderwat.indent-rainbow
      # Git
      codezombiech.gitignore
      waderyan.gitblame
      # Common
      editorconfig.editorconfig
      github.github-vscode-theme
      gruntfuggly.todo-tree
      tamasfe.even-better-toml
      redhat.vscode-yaml
      usernamehw.errorlens
    ];

    userSettings = {
      "chat.disableAIFeatures" = lib.mkDefault true;

      "window.titleBarStyle" = lib.mkForce "native";
      "window.menuStyle" = lib.mkForce "custom";
      "window.commandCenter" = lib.mkDefault false;
      "window.openFilesInNewWindow" = lib.mkDefault "off";
      "window.openFoldersInNewWindow" = lib.mkDefault "on";
      "window.autoDetectColorScheme" = lib.mkDefault true;

      "workbench.startupEditor" = lib.mkDefault "none";
      "workbench.preferredDarkColorTheme" = lib.mkDefault "GitHub Dark Colorblind (Beta)";
      "workbench.preferredLightColorTheme" = lib.mkDefault "GitHub Light Colorblind (Beta)";

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

      "redhat.telemetry.enabled" = false;

      "security.workspace.trust.enabled" = lib.mkDefault false;
    };
  };
in
{
  programs.vscode.enable = true;
  programs.vscode.package = repo.vscode;
  programs.vscode.mutableExtensionsDir = false;

  programs.vscode.profiles.default = tools.merge preset {
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
  };

  programs.vscode.profiles.Go = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      golang.go
    ];

    userSettings = {
      "go.showWelcome" = false;
    };
  };

  programs.vscode.profiles.Nix = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      jnoortheen.nix-ide
    ];

    userSettings = {
      "nix.enableLanguageServer" = lib.mkDefault true;
      "nix.serverPath" = lib.mkDefault "nixd";
      "nix.formatterPath" = lib.mkDefault "nixfmt";
    };
  };

  programs.vscode.profiles.Rust = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
    ];
  };

  programs.vscode.profiles.Java = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      mathiasfrohlich.kotlin
    ];
  };

  programs.vscode.profiles.Python = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      ms-python.python
      ms-python.debugpy
      ms-python.isort
      ms-python.vscode-pylance
    ];
  };

  programs.vscode.profiles."C++" = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      vadimcn.vscode-lldb
    ];
  };

  programs.vscode.profiles.Net = tools.merge preset {
    extensions = with repo.vscode-extensions; [
      ms-dotnettools.csdevkit
      ms-dotnettools.csharp
      ms-dotnettools.vscode-dotnet-runtime
    ];
  };
}
