{
  _vsc_pkg_,
  _vsc_profile_,
  pkgs,
  ...
}:
let
  market_1 = pkgs.repos.unstable.vscode-extensions;
  market_2 = pkgs.repos.vscode.vscode-marketplace-release;
in
{
  programs.${_vsc_pkg_}.profiles.Go = _vsc_profile_ {
    extensions = [
      market_1.golang.go
      market_2.bufbuild.vscode-buf
    ];
    userSettings = {
      "go.showWelcome" = false;
      "go.diagnostic.vulncheck" = "Off";
    };
  };
}
