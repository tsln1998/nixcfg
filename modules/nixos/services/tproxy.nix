{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.tproxy;
in
{
  options.services.tproxy = {
    enable = lib.mkEnableOption "tproxy service";

    after = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "systemd service after";
    };

    rtmark = lib.mkOption {
      type = lib.types.number;
      default = 666;
      description = "routing-mark used in your VPN application";
    };

    fwmark = lib.mkOption {
      type = lib.types.number;
      default = 1;
      description = "firewall mark on nftables";
    };

    tables = {
      ipv4 = lib.mkOption {
        type = lib.types.number;
        default = 100;
        description = "ip route table for IPv4";
      };
    };

    tcpTo = lib.mkOption {
      type = lib.types.port;
      default = 7891;
      description = "tproxy redirect tcp to";
    };

    udpTo = lib.mkOption {
      type = lib.types.port;
      default = 7891;
      description = "tproxy redirect udp to";
    };

    dnsTo = lib.mkOption {
      type = lib.types.port;
      default = 7891;
      description = "tproxy redirect dns to";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iproute2
    ];

    networking.nftables = {
      enable = true;
      tables = {
        tproxy-redirect = {
          family = "inet";
          content = ''
            chain prerouting {
              type filter hook prerouting priority mangle
              policy accept

              ip daddr {10.0.0.0/8,100.64.0.0/10,127.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.0.0.0/24,224.0.0.0/4,255.255.255.255/32} return

              ip daddr 192.168.0.0/16 tcp dport != 53 return
              ip daddr 192.168.0.0/16 udp dport != 53 return

              ip protocol tcp tproxy ip to 127.0.0.1:${toString cfg.tcpTo} meta mark set ${toString cfg.fwmark}
              ip protocol udp tproxy ip to 127.0.0.1:${toString cfg.udpTo} meta mark set ${toString cfg.fwmark}
            }
            chain output {
              type route hook output priority mangle
              policy accept

              ip daddr {10.0.0.0/8,100.64.0.0/10,127.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.0.0.0/24,224.0.0.0/4,255.255.255.255/32} return

              ip daddr 192.168.0.0/16 tcp dport != 53 return
              ip daddr 192.168.0.0/16 udp dport != 53 return

              meta mark ${toString cfg.rtmark} return

              ip protocol tcp meta mark set ${toString cfg.fwmark}
              ip protocol udp meta mark set ${toString cfg.fwmark}
            }
          '';
        };
      };
    };

    systemd.services.tproxy =
      let
        ip = lib.getExe' pkgs.iproute2 "ip";
      in
      {
        description = "Setup tproxy redirect";

        wantedBy = [ "multi-user.target" ] ++ cfg.after;
        after = [ "network.target" ] ++ cfg.after;

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;

          ExecStart = pkgs.writeShellScript "tproxy-start" ''
            ${ip} route add local default dev lo table ${toString cfg.tables.ipv4}
            ${ip} rule add fwmark ${toString cfg.fwmark} table ${toString cfg.tables.ipv4}
          '';

          ExecStop = pkgs.writeShellScript "tproxy-stop" ''
            ${ip} route flush table ${toString cfg.tables.ipv4}
            ${ip} rule del fwmark ${toString cfg.fwmark} table ${toString cfg.tables.ipv4}
          '';
        };
      };
  };
}
