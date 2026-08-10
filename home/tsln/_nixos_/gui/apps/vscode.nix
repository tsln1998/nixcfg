{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.fonts.fontconfig) defaultFonts;

  pkg = pkgs.repos.unstable.vscodium;
  market_1 = pkgs.repos.unstable.vscode-extensions;
  market_2 = pkgs.repos.vscode.vscode-marketplace-release;

  langProfiles = {
    default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
    };
  };

  langExtensions = rec {
    default = [
      # Keybindings
      market_1.k--kato.intellij-idea-keybindings
      # Themes
      market_1.github.github-vscode-theme
      market_1.pkief.material-icon-theme
      market_1.miguelsolorio.fluent-icons
      # Rainbow
      market_1.oderwat.indent-rainbow
      # Git
      market_1.codezombiech.gitignore
      market_1.waderyan.gitblame
      # Nix
      market_1.jnoortheen.nix-ide
      # Direnv
      market_1.mkhl.direnv
      # Common
      market_1.editorconfig.editorconfig
      market_1.gruntfuggly.todo-tree
      market_1.tamasfe.even-better-toml
      market_1.redhat.vscode-yaml
      market_1.usernamehw.errorlens
    ];

    Go = [
      market_1.golang.go
      market_2.bufbuild.vscode-buf
    ];

    Rust = [
      market_1.rust-lang.rust-analyzer
      market_1.vadimcn.vscode-lldb
    ];

    Python = [
      market_1.ms-python.python
      market_1.ms-python.debugpy
      market_1.ms-python.isort
      market_1.ms-python.vscode-pylance
      market_2.ms-python.autopep8
    ];

    Cxx = [
      market_1.ms-vscode.cpptools
      market_1.ms-vscode.cmake-tools
      market_1.vadimcn.vscode-lldb
    ];

    All = Go ++ Rust ++ Python ++ Cxx;
  };

  langSettings = rec {
    default = {
      "window.titleBarStyle" = lib.mkForce "native";
      "window.menuStyle" = lib.mkForce "custom";
      
      "window.commandCenter" = lib.mkDefault false;
      "window.autoDetectColorScheme" = lib.mkDefault true;
      "window.openFilesInNewWindow" = lib.mkDefault "off";
      "window.openFoldersInNewWindow" = lib.mkDefault "on";
      "window.title" = lib.mkDefault "\${rootName}\${separator}\${appName}";

      "workbench.startupEditor" = lib.mkDefault "none";
      "workbench.editor.useModal" = lib.mkDefault "off";
      "workbench.settings.editor" = lib.mkDefault "json";
      "workbench.iconTheme" = lib.mkDefault "material-icon-theme";
      "workbench.productIconTheme" = lib.mkDefault "fluent-icons";
      "workbench.preferredLightColorTheme" = lib.mkDefault "GitHub Light";
      "workbench.preferredDarkColorTheme" = lib.mkDefault "GitHub Dark";

      "files.autoSaveWhenNoErrors" = lib.mkDefault true;
      "files.autoSaveWorkspaceFilesOnly" = lib.mkDefault true;
      "files.eol" = lib.mkDefault "\n";
      "files.enableTrash" = lib.mkDefault false;

      "editor.fontLigatures" = lib.mkDefault true;
      "editor.fontFamily" = lib.mkDefault (
        lib.strings.concatStringsSep ", " (
          map (font: "'${font}'") (
            defaultFonts.monospace ++ defaultFonts.sansSerif ++ defaultFonts.serif ++ defaultFonts.emoji
          )
        )
      );
      "editor.cursorSmoothCaretAnimation" = lib.mkDefault "on";
      "editor.cursorBlinking" = lib.mkDefault "phase";
      "editor.inlineSuggest.enabled" = lib.mkDefault true;
      "editor.acceptSuggestionOnCommitCharacter" = lib.mkDefault false;
      "editor.guides.bracketPairs" = lib.mkDefault true;
      "editor.formatOnSave" = lib.mkDefault false;
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

      "nix.enableLanguageServer" = lib.mkDefault true;
      "nix.serverPath" = lib.mkDefault "nixd";
      "nix.formatterPath" = lib.mkDefault "nixfmt";

      "security.workspace.trust.enabled" = lib.mkDefault false;

      "redhat.telemetry.enabled" = lib.mkDefault false;

      "update.showReleaseNotes" = lib.mkDefault false;
    };

    Go = {
      "go.showWelcome" = false;
      "go.diagnostic.vulncheck" = "Off";
    };

    All = Go;
  };

  names = lib.attrNames (langExtensions // langSettings);
in
{
  # 生成 Profiles
  programs.${pkg.pname} = {
    enable = true;
    package = pkg;
    mutableExtensionsDir = false;
    profiles = lib.genAttrs names (
      name:
      (langProfiles.${name} or { })
      // {
        extensions = (langExtensions.default or [ ]) ++ (langExtensions.${name} or [ ]);
        userSettings = (langSettings.default or { }) // (langSettings.${name} or { });
      }
    );
  };
}
