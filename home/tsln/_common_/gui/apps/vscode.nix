{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.fonts.fontconfig) defaultFonts;

  # 变体包
  pkg = pkgs.repos.unstable.vscodium;
  market = pkgs.repos.unstable.vscode-extensions;

  # 基础扩展
  baseExtensions = [
    # Keybindings
    market.k--kato.intellij-idea-keybindings
    # Themes
    market.github.github-vscode-theme
    market.pkief.material-icon-theme
    market.miguelsolorio.fluent-icons
    # Rainbow
    market.oderwat.indent-rainbow
    # Git
    market.codezombiech.gitignore
    market.waderyan.gitblame
    # Nix
    market.jnoortheen.nix-ide
    # Direnv
    market.mkhl.direnv
    # Common
    market.editorconfig.editorconfig
    market.gruntfuggly.todo-tree
    market.tamasfe.even-better-toml
    market.redhat.vscode-yaml
    market.usernamehw.errorlens
  ];

  # 基础用户设置
  baseSettings = {
    "chat.disableAIFeatures" = lib.mkDefault true;

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

  # 基础键盘映射
  baseKeybindings = [
    {
      key = "ctrl+p";
      command = "-workbench.action.quickOpen";
    }
    {
      key = "ctrl+p";
      command = "-editor.action.triggerParameterHints";
      when = "editorHasSignatureHelpProvider && editorTextFocus";
    }
    {
      key = "ctrl+p";
      command = "-workbench.action.quickOpenNavigateNextInFilePicker";
      when = "inFilesPicker && inQuickOpen";
    }
    {
      key = "f1";
      command = "-editor.action.showHover";
      when = "editorTextFocus";
    }
  ];
in
{
  # 生成 Profiles
  programs.${pkg.pname} = {
    enable = true;
    package = pkg;
    mutableExtensionsDir = false;
    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = baseExtensions;
        userSettings = baseSettings;
        keybindings = baseKeybindings;
      };
    };
  };

  # 生成别名
  home.shellAliases = lib.optionals (pkgs.vscode.meta.mainProgram != pkg.meta.mainProgram) {
    ${pkgs.vscode.meta.mainProgram} = pkg.meta.mainProgram;
  };
}
