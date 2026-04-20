{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.warp;
in
{
  options.services.warp = {
    enable = lib.mkEnableOption "Cloudflare WARP socks5 proxy service";

    name = lib.mkOption {
      type = lib.types.str;
      default = "warp";
      description = "Cloudflare WARP container name";
    };

    tag = lib.mkOption {
      type = lib.types.str;
      default = "slim-2026.3.846.0-2.12.0";
      description = "Cloudflare WARP image tag";
    };

    dns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      description = "Cloudflare WARP dns server";
    };

    listen = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "socks5 listen address";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 1080;
      description = "sock5 listen port";
    };

    checker = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Cloudflare WARP health check enable";
      };

      url = lib.mkOption {
        type = lib.types.str;
        default = "https://cloudflare.com/cdn-cgi/trace";
        description = "Cloudflare WARP health check url";
      };

      timeout = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "Cloudflare WARP health check timeout (seconds)";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    let
      unit = "${cfg.name}.service";
    in
    {
      virtualisation.oci-containers.containers.${cfg.name} = {
        serviceName = cfg.name;

        image = "caomingjun/warp:${cfg.tag}";

        ports = [
          "${cfg.listen}:${toString cfg.port}:1080"
        ];

        capabilities = {
          MKNOD = true;
          NET_ADMIN = true;
          AUDIT_WRITE = true;
        };

        volumes = [
          "${cfg.name}:/var/lib/cloudflare-warp"
        ];

        extraOptions = [
          "--device-cgroup-rule=c 10:200 rwm"
          "--sysctl=net.ipv6.conf.all.disable_ipv6=0"
          "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
        ]
        ++ (map (addr: "--dns=${addr}") cfg.dns);
      };

      systemd = lib.mkIf cfg.checker.enable (
        let
          inherit (cfg) checker;
          service = "${cfg.name}-checker";

          curl = lib.getExe' pkgs.curl "curl";
          systemctl = lib.getExe' config.systemd.package "systemctl";
        in
        {
          services.${service} = {
            description = "Check ${cfg.name} proxy and restart container if needed";
            after = [ unit ];
            wants = [ unit ];
            serviceConfig = {
              Type = "oneshot";
              ExecStart = pkgs.writeShellScript service ''
                ${curl} ${checker.url} \
                  -fsS \
                  --max-time ${toString checker.timeout} \
                  -x socks5h://127.0.0.1:${toString cfg.port} >/dev/null || \
                ${systemctl} restart ${unit}
              '';
            };
          };

          timers.${service} = {
            wantedBy = [ "timers.target" ];
            timerConfig = {
              Unit = unit;
              OnBootSec = "15min";
              OnUnitActiveSec = "1min";
            };
          };
        }
      );
    }
  );
}
