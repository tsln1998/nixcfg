{
  lib,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  path = "${homeDirectory}/.cargo";
in
{
  # go environment variables
  home.sessionVariables = {
    CARGO_HOME = lib.mkDefault path;
  };

  # go paths
  home.sessionPath = [
    "${path}/bin"
  ];
}
