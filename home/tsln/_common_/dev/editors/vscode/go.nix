{
  _vsc_pkg_,
  _vsc_profile_,
  pkgs,
  ...
}:
let
  market = pkgs.vscode-extensions;
in
{
  programs.${_vsc_pkg_}.profiles.Go = _vsc_profile_ {
    extensions = [
      market.golang.go
      market.bufbuild.vscode-buf
      market.openfga.openfga-vscode
    ];
    userSettings = {
      "go.showWelcome" = false;
      "go.diagnostic.vulncheck" = "Off";
    };
  };
}
