{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.programs.pkg-config;
in
{
  options.programs.pkg-config = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pkg-config;
    };
    paths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    home.sessionVariables = lib.optionals (cfg.paths != [ ]) {
      PKG_CONFIG_PATH = lib.concatStringsSep ";" cfg.paths;
    };
  };
}
