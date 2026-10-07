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
  programs.${_vsc_pkg_}.profiles.Flutter = _vsc_profile_ {
    extensions = [
      market.dart-code.dart-code
      market.dart-code.flutter
    ];
  };
}
