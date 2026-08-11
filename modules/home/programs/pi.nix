{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.pi;
in
{
  # Home Manager 配置项。
  options.programs.pi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable pi-coding-agent.";
    };
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = pkgs.pi-coding-agent;
      description = "The pi-coding-agent package to install; set to null to skip installation.";
    };
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "The extra packages for pi-coding-agentto install.";
    };
    models = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.oneOf [
          lib.types.path
          lib.types.attrs
        ]
      );
      default = null;
      description = "Model configuration written or linked to ~/.pi/agent/models.json.";
    };
    settings = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.oneOf [
          lib.types.path
          lib.types.attrs
        ]
      );
      default = null;
      description = "Agent settings written or linked to ~/.pi/agent/settings.json.";
    };
  };

  # 仅在启用 Pi 时写入配置并安装软件包。
  config = lib.mkIf cfg.enable {
    # package 为 null 时只安装拓展包，不安装 Pi。
    home.packages =
      cfg.extraPackages
      ++ (lib.optionals (cfg.package != null) [
        cfg.package
      ]);

    # attrs 序列化为 JSON，path 则直接链接到目标文件。
    home.file =
      # 将内联模型配置写入 models.json。
      (lib.optionalAttrs (lib.isAttrs cfg.models) {
        ".pi/agent/models.json" = {
          text = lib.strings.toJSON cfg.models;
        };
      })
      # 链接外部模型配置文件。
      // (lib.optionalAttrs (lib.isPath cfg.models) {
        ".pi/agent/models.json" = {
          source = cfg.models;
        };
      })
      # 将内联设置写入 settings.json。
      // (lib.optionalAttrs (lib.isAttrs cfg.settings) {
        ".pi/agent/settings.json" = {
          text = lib.strings.toJSON cfg.settings;
        };
      })
      # 链接外部设置文件。
      // (lib.optionalAttrs (lib.isPath cfg.settings) {
        ".pi/agent/settings.json" = {
          source = cfg.settings;
        };
      });
  };
}
