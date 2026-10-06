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
  programs.${_vsc_pkg_}.profiles.Python = _vsc_profile_ {
    extensions = [
      market.ms-python.python
      market.ms-python.debugpy
      market.ms-python.isort
      market.ms-python.vscode-pylance
      market_.ms-python.autopep8
    ];
  };
}
