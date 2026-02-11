{
  lib,
  pkgs,
  ...
}:
let
  repo = pkgs.unstable;

  # 基础扩展
  baseExtensions = with repo.vscode-extensions; [
    # Keybindings
    k--kato.intellij-idea-keybindings
    # Rainbow
    oderwat.indent-rainbow
    # Git
    codezombiech.gitignore
    waderyan.gitblame
    # Nix
    jnoortheen.nix-ide
    # Direnv
    mkhl.direnv
    # Common
    editorconfig.editorconfig
    gruntfuggly.todo-tree
    tamasfe.even-better-toml
    redhat.vscode-yaml
    usernamehw.errorlens
  ];

  # 基础用户设置
  baseSettings = {
    "chat.disableAIFeatures" = lib.mkDefault true;

    "window.titleBarStyle" = lib.mkForce "native";
    "window.menuStyle" = lib.mkForce "custom";
    "window.commandCenter" = lib.mkDefault false;
    "window.openFilesInNewWindow" = lib.mkDefault "off";
    "window.openFoldersInNewWindow" = lib.mkDefault "on";

    "workbench.startupEditor" = lib.mkDefault "none";

    "files.autoSaveWhenNoErrors" = lib.mkDefault true;
    "files.autoSaveWorkspaceFilesOnly" = lib.mkDefault true;
    "files.eol" = lib.mkDefault "\n";

    "editor.fontLigatures" = lib.mkDefault true;
    "editor.fontFamily" = lib.mkDefault (
      lib.strings.concatStringsSep ", " [
        "'Jetbrains Mono'"
        "'Noto Sans CJK SC'"
        "'Noto Serif CJK SC'"
        "'Noto Color Emoji'"
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

    "diffEditor.renderSideBySide" = lib.mkDefault false;

    "nix.enableLanguageServer" = lib.mkDefault true;
    "nix.serverPath" = lib.mkDefault "nixd";
    "nix.formatterPath" = lib.mkDefault "nixfmt";

    "security.workspace.trust.enabled" = lib.mkDefault false;

    "update.showReleaseNotes" = false;
  };

  # 语言特定扩展配置（不包含基础扩展）
  langExtensions = rec {
    Go =
      (with repo.vscode-extensions; [
        golang.go
      ])
      ++ (with pkgs.additions; [
        vscode-extensions_vscode-buf
      ]);

    Rust = with repo.vscode-extensions; [
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
    ];

    Zig = with repo.vscode-extensions; [
      ziglang.vscode-zig
      vadimcn.vscode-lldb
    ];

    Java = with repo.vscode-extensions; [
      mathiasfrohlich.kotlin
    ];

    Python =
      (with repo.vscode-extensions; [
        ms-python.python
        ms-python.debugpy
        ms-python.isort
        ms-python.vscode-pylance
      ])
      ++ (with pkgs.additions; [
        vscode-extensions_autopep8
      ]);

    Cxx = with repo.vscode-extensions; [
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      vadimcn.vscode-lldb
    ];

    All = Go ++ Rust ++ Zig ++ Java ++ Python ++ Cxx;
  };

  # 语言特定用户设置
  langSettings = rec {
    Go = {
      "go.showWelcome" = false;
      "go.diagnostic.vulncheck" = "Off";
    };

    Zig = {
      "zig.zls.enabled" = "on";
    };

    All = Go // Zig;
  };

  # 提取配置名称
  names = lib.attrNames (langExtensions // langSettings);
in
{
  programs.vscode.enable = true;
  programs.vscode.package = repo.vscode;
  programs.vscode.mutableExtensionsDir = false;

  # 生成 profiles
  programs.vscode.profiles = {
    default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = baseExtensions;
      userSettings = baseSettings;
    };
  }
  // (lib.genAttrs names (lang: {
    extensions = baseExtensions ++ (langExtensions.${lang} or [ ]);
    userSettings = baseSettings // (langSettings.${lang} or { });
  }));

  # 生成 catppuccin 配置
  catppuccin.vscode.profiles = {
    default = {
      enable = true;
    };
  }
  // (lib.genAttrs names (lang: {
    enable = true;
  }));
}
