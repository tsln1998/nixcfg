{
  lib,
  pkgs,
  tools,
  ...
}:
let
  repo = pkgs.unstable;

  # 基础扩展
  baseExtensions =
    (with repo.vscode-extensions; [
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
      github.github-vscode-theme
      gruntfuggly.todo-tree
      tamasfe.even-better-toml
      redhat.vscode-yaml
      usernamehw.errorlens
    ])
    ++ (with pkgs.additions; [
      # gRPC
      vscode-extensions_vscode-buf
    ]);

  # 基础用户设置
  baseUserSettings = {
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

    "redhat.telemetry.enabled" = lib.mkDefault false;

    "security.workspace.trust.enabled" = lib.mkDefault false;
  };

  # 语言特定扩展配置（不包含基础扩展）
  langExtensions = {
    go = with repo.vscode-extensions; [
      golang.go
    ];

    rust = with repo.vscode-extensions; [
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
    ];

    zig = with repo.vscode-extensions; [
      ziglang.vscode-zig
      vadimcn.vscode-lldb
    ];

    java = with repo.vscode-extensions; [
      mathiasfrohlich.kotlin
    ];

    python =
      (with repo.vscode-extensions; [
        ms-python.python
        ms-python.debugpy
        ms-python.isort
        ms-python.vscode-pylance
      ])
      ++ (with pkgs.additions; [
        vscode-extensions_autopep8
      ]);

    cxx = with repo.vscode-extensions; [
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      vadimcn.vscode-lldb
    ];

    net = with repo.vscode-extensions; [
      ms-dotnettools.csdevkit
      ms-dotnettools.csharp
      ms-dotnettools.vscode-dotnet-runtime
    ];
  };

  # 语言特定用户设置
  langUserSettings = {
    go = {
      "go.showWelcome" = false;
    };

    zig = {
      "zig.zls.enabled" = "on";
    };
  };

  # 所有语言的扩展列表
  allLangExtensions =
    langExtensions.go
    ++ langExtensions.rust
    ++ langExtensions.zig
    ++ langExtensions.java
    ++ langExtensions.python
    ++ langExtensions.cxx
    ++ langExtensions.net;

  # 所有语言的用户设置
  allLangUserSettings = (langUserSettings.go or { }) // (langUserSettings.zig or { });
in
{
  imports = [
    (tools.relative "home/common/apps/vscode.nix")
  ];

  # Default profile: 仅基础配置
  programs.vscode.profiles.default = {
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = baseExtensions;
    userSettings = baseUserSettings;
  };

  # All profile: 基础 + 所有语言
  programs.vscode.profiles.All = {
    extensions = baseExtensions ++ allLangExtensions;
    userSettings = baseUserSettings // allLangUserSettings;
  };

  # Go profile: 基础 + Go
  programs.vscode.profiles.Go = {
    extensions = baseExtensions ++ langExtensions.go;
    userSettings = baseUserSettings // (langUserSettings.go or { });
  };

  # Rust profile: 基础 + Rust
  programs.vscode.profiles.Rust = {
    extensions = baseExtensions ++ langExtensions.rust;
    userSettings = baseUserSettings;
  };

  # Zig profile: 基础 + Zig
  programs.vscode.profiles.Zig = {
    extensions = baseExtensions ++ langExtensions.zig;
    userSettings = baseUserSettings // (langUserSettings.zig or { });
  };

  # Java profile: 基础 + Java
  programs.vscode.profiles.Java = {
    extensions = baseExtensions ++ langExtensions.java;
    userSettings = baseUserSettings;
  };

  # Python profile: 基础 + Python
  programs.vscode.profiles.Python = {
    extensions = baseExtensions ++ langExtensions.python;
    userSettings = baseUserSettings;
  };

  # Cxx profile: 基础 + C++
  programs.vscode.profiles.Cxx = {
    extensions = baseExtensions ++ langExtensions.cxx;
    userSettings = baseUserSettings;
  };

  # Net profile: 基础 + .NET
  programs.vscode.profiles.Net = {
    extensions = baseExtensions ++ langExtensions.net;
    userSettings = baseUserSettings;
  };
}
