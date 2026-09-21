{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.programs.pixi;

  toml = pkgs.formats.toml { };
in
{
  options.programs.pixi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pixi;
    };
    settings = lib.mkOption {
      type = lib.types.nullOr lib.types.attrs;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
    home.file = lib.optionalAttrs (cfg.settings != null) {
      ".pixi/config.toml" = {
        source = toml.generate "pixi-config.toml" cfg.settings;
      };
    };
  };
}
