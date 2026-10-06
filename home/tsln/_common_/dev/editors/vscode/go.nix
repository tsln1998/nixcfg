{
  _vsc_pkg_,
  _vsc_profile_,
  pkgs,
  ...
}:
let
  market = pkgs.repos.unstable.vscode-extensions;
  market_ = pkgs.repos.vscode.vscode-marketplace-release;
in
{
  programs.${_vsc_pkg_}.profiles.Go = _vsc_profile_ {
    extensions = [
      market.golang.go
      market_.bufbuild.vscode-buf
      market_.openfga.openfga-vscode
    ];
    userSettings = {
      "go.showWelcome" = false;
      "go.diagnostic.vulncheck" = "Off";
    };
  };
}
