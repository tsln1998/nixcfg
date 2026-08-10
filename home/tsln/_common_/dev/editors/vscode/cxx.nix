{
  _vsc_pkg_,
  _vsc_profile_,
  pkgs,
  ...
}:
let
  market = pkgs.repos.unstable.vscode-extensions;
in
{
  programs.${_vsc_pkg_}.profiles.Cxx = _vsc_profile_ {
    extensions = [
      market.ms-vscode.cpptools
      market.ms-vscode.cmake-tools
      market.vadimcn.vscode-lldb
    ];
  };
}
