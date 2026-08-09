{
  config,
  pkgs,
  ...
}:
let
  pkg = pkgs.repos.unstable.vscodium;
  market_1 = pkgs.repos.unstable.vscode-extensions;
  market_2 = pkgs.repos.vscode.vscode-marketplace-release;

  inherit (config.programs.${pkg.pname}) profiles;
  inherit (config.programs.${pkg.pname}.profiles) default;
in
{
  # 生成 Profiles
  programs.${pkg.pname}.profiles.Go = default // {
    extensions = default.extensions ++ [
      market_1.golang.go
      market_2.bufbuild.vscode-buf
    ];

    userSettings = default.userSettings // {
      "go.showWelcome" = false;
      "go.diagnostic.vulncheck" = "Off";
    };
  };

  programs.${pkg.pname}.profiles.Rust = default // {
    extensions = default.extensions ++ [
      market_1.rust-lang.rust-analyzer
      market_1.vadimcn.vscode-lldb
    ];
  };

  programs.${pkg.pname}.profiles.Python = default // {
    extensions = default.extensions ++ [
      market_1.ms-python.python
      market_1.ms-python.debugpy
      market_1.ms-python.isort
      market_1.ms-python.vscode-pylance
      market_2.ms-python.autopep8
    ];
  };

  programs.${pkg.pname}.profiles.CXX = default // {
    extensions = default.extensions ++ [
      market_1.ms-vscode.cpptools
      market_1.ms-vscode.cmake-tools
      market_1.vadimcn.vscode-lldb
    ];
  };

  programs.${pkg.pname}.profiles.All = default // {
    extensions =
      default.extensions
      ++ profiles.Go.extensions
      ++ profiles.Rust.extensions
      ++ profiles.Python.extensions
      ++ profiles.CXX.extensions;
    userSettings =
      default.userSettings
      // profiles.Go.userSettings
      // profiles.Rust.userSettings
      // profiles.Python.userSettings
      // profiles.CXX.userSettings;
  };

}
