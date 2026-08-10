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
  programs.${_vsc_pkg_}.profiles.Python = _vsc_profile_ {
    extensions = [
      market_1.ms-python.python
      market_1.ms-python.debugpy
      market_1.ms-python.isort
      market_1.ms-python.vscode-pylance
      market_2.ms-python.autopep8
    ];
  };
}
