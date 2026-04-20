{lib, config, pkgs, ... }:
let
  inherit (config.virtualisation.oci-containers) backend;

  name = "warp";
  port = 1080;
  checker = "${backend}-${name}-checker";

  curl = lib.getExe' pkgs.curl "curl";
  systemctl = lib.getExe' config.systemd.package "systemctl";
in
{
  virtualisation.oci-containers.containers.${name} = {
    image = "caomingjun/warp:slim-2026.3.846.0-2.12.0";

    ports = [
      "127.0.0.1:${toString port}:1080"
    ];

    capabilities = {
      MKNOD = true;
      NET_ADMIN = true;
      AUDIT_WRITE = true;
    };

    volumes = [
      "${name}:/var/lib/cloudflare-warp"
    ];

    extraOptions = [
      "--dns=1.1.1.1"
      "--dns=1.0.0.1"
      "--device-cgroup-rule=c 10:200 rwm"
      "--sysctl=net.ipv6.conf.all.disable_ipv6=0"
      "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
    ];
  };

  systemd.services.${checker} = {
    description = "Check ${name} proxy and restart container if needed";
    after = [ "${backend}-${name}.service" ];
    wants = [ "${backend}-${name}.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript checker ''
        ${curl} https://cloudflare.com/cdn-cgi/trace \
          -fsS
          --max-time 1 \
          -x socks5h://127.0.0.1:${toString port} >/dev/null || \
        ${systemctl} restart ${backend}-${name}
      '';
    };
  };

  systemd.timers.${checker} = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "${checker}.service";
      OnBootSec = "1min";
      OnUnitActiveSec = "15s";
    };
  };
}
