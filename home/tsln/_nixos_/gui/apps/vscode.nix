{
  lib,
  pkgs,
  _vsc_base_profile,
  ...
}:
let
  pkg = pkgs.repos.unstable.vscodium;
  market_1 = pkgs.repos.unstable.vscode-extensions;
  market_2 = pkgs.repos.vscode.vscode-marketplace-release;

  langExtensions = rec {
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
  programs.${pkg.pname}.profiles = lib.genAttrs names (
    name:
    _vsc_base_profile
    // {
      extensions = _vsc_base_profile.extensions ++ (langExtensions.${name} or [ ]);
      userSettings =
        _vsc_base_profile.userSettings
        // {
          "window.titleBarStyle" = lib.mkForce "native";
          "window.menuStyle" = lib.mkForce "custom";
        }
        // (langSettings.${name} or { });
    }
  );

}
