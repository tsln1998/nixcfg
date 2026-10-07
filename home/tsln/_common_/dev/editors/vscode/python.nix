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
  programs.${_vsc_pkg_}.profiles.Python = _vsc_profile_ {
    extensions = [
      market.ms-python.python
      market.ms-python.debugpy
      market.ms-python.isort
      market.ms-python.vscode-pylance
      market.ms-python.autopep8
    ];
  };
}
