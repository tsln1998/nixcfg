{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.pi;

  inherit (lib) mkIf mkOption;
  inherit (lib) optionals optionalAttrs;
  inherit (lib) isAttrs isString isPath;
  inherit (lib.strings) toJSON;
  inherit (lib.types)
    oneOf
    listOf
    nullOr
    submodule
    ;
  inherit (lib.types) str bool path;
  inherit (lib.types)
    attrs
    attrsOf
    anything
    package
    ;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # Home Manager 配置项。
  options.programs.pi = {
    enable = mkOption {
      type = bool;
      default = false;
      description = "Whether to enable pi-coding-agent.";
    };
    package = mkOption {
      type = nullOr package;
      default = pkgs.pi-coding-agent;
      description = "The pi-coding-agent package to install; set to null to skip installation.";
    };
    extraPackages = mkOption {
      type = listOf package;
      default = [ ];
      description = "The extra packages for pi-coding-agentto install.";
    };
    models = mkOption {
      type = nullOr (oneOf [
        str
        path
        attrs
      ]);
      default = null;
      description = "Model configuration written or linked to ~/.pi/agent/models.json.";
    };
    settings = mkOption {
      type = nullOr (oneOf [
        str
        path
        (submodule {
          freeformType = attrsOf anything;

          options.packages = mkOption {
            type = listOf str;
            default = [ ];
            description = "Pi extension packages.";
          };
        })
      ]);
      default = null;
      description = "Agent settings written or linked to ~/.pi/agent/settings.json.";
    };
  };

  # 仅在启用 Pi 时写入配置并安装软件包。
  config = mkIf cfg.enable {
    # package 为 null 时只安装拓展包，不安装 Pi。
    home.packages =
      cfg.extraPackages
      ++ (optionals (cfg.package != null) [
        cfg.package
      ]);

    # attrs 序列化为 JSON，path 则直接链接到目标文件。
    home.file =
      # 将内联模型配置写入 models.json。
      (optionalAttrs (isAttrs cfg.models) {
        ".pi/agent/models.json" = {
          text = toJSON cfg.models;
        };
      })
      # 链接外部模型配置文件。
      // (optionalAttrs ((isString cfg.models) || (isPath cfg.models)) {
        ".pi/agent/models.json" = {
          source = if isString cfg.models then mkOutOfStoreSymlink cfg.models else cfg.models;
        };
      })
      # 将内联设置写入 settings.json。
      // (optionalAttrs (isAttrs cfg.settings) {
        ".pi/agent/settings.json" = {
          text = toJSON cfg.settings;
        };
      })
      # 链接外部设置文件。
      // (optionalAttrs ((isString cfg.settings) || (isPath cfg.settings)) {
        ".pi/agent/settings.json" = {
          source = if isString cfg.settings then mkOutOfStoreSymlink cfg.settings else cfg.settings;
        };
      });
  };
}
