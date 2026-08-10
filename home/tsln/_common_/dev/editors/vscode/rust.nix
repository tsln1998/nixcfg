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
  programs.${_vsc_pkg_}.profiles.Rust = _vsc_profile_ {
    extensions = [
      market.rust-lang.rust-analyzer
      market.vadimcn.vscode-lldb
    ];
  };
}
