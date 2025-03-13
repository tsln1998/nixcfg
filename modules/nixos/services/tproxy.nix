{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.tproxy;
  reversed = lib.concatStringsSep "," [
    "10.0.0.0/8"
    "100.64.0.0/10"
    "127.0.0.0/8"
    "169.254.0.0/16"
    "172.16.0.0/12"
    "192.0.0.0/24"
    "192.168.0.0/16"
    "224.0.0.0/4"
    "255.255.255.255/32"
  ];
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

    table = lib.mkOption {
      type = lib.types.number;
      default = 100;
      description = "ip route table";
    };

    subnet = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "redirect subnet";
    };

    tcpTo = lib.mkOption {
      type = lib.types.port;
      default = 7891;
      description = "redirect tcp to (tproxy)";
    };

    udpTo = lib.mkOption {
      type = lib.types.port;
      default = 7891;
      description = "redirect udp to (tproxy)";
    };

    dnsTo = lib.mkOption {
      type = lib.types.nullOr lib.types.port;
      default = null;
      description = "redirect dns to (tproxy)";
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
          family = "ip";
          content = lib.concatStringsSep "\n" [
            (lib.optionalString (cfg.dnsTo != null) ''
              chain dns-prerouting {
                type nat hook prerouting priority dstnat
                policy accept
                
                meta mark ${toString cfg.rtmark} return

                udp dport 53 meta mark set ${toString cfg.rtmark} redirect to :${toString cfg.dnsTo}
              }

              chain dns-output {
                type nat hook output priority dstnat
                policy accept

                meta mark ${toString cfg.rtmark} return

                udp dport 53 meta mark set ${toString cfg.rtmark} redirect to :${toString cfg.dnsTo}
              }
            '')
            (
              if cfg.subnet == null then
                ''
                  chain prerouting {
                    type filter hook prerouting priority mangle
                    policy accept

                    # bypass processed outbound
                    meta mark ${toString cfg.rtmark} return
                    
                    # bypass reserved addrs
                    ip daddr {${reversed}} return

                    # bypass dns query (redirect on nat)
                    ${lib.optionalString (cfg.dnsTo != null) ''
                      udp dport 53 return
                    ''}

                    # proxy tcp traffic
                    ip protocol tcp tproxy ip to :${toString cfg.tcpTo} meta mark set ${toString cfg.fwmark}
                    # proxy udp traffic
                    ip protocol udp tproxy ip to :${toString cfg.udpTo} meta mark set ${toString cfg.fwmark}
                  }

                  chain output {
                    type route hook output priority mangle
                    policy accept

                    # bypass processed outbound
                    meta mark ${toString cfg.rtmark} return

                    # bypass reserved addrs
                    ip daddr {${reversed}} return

                    # mark default outbound
                    ip protocol { tcp, udp } meta mark set ${toString cfg.fwmark}
                  }
                ''
              else
                ''
                  chain prerouting {
                    type filter hook prerouting priority mangle
                    policy accept

                    # bypass processed outbound
                    meta mark ${toString cfg.rtmark} return

                    # bypass dns query (redirect on nat)
                    ${lib.optionalString (cfg.dnsTo != null) ''
                      udp dport 53 return
                    ''}

                    # proxy tcp traffic
                    ip protocol tcp ip daddr ${cfg.subnet} tproxy ip to :${toString cfg.tcpTo} meta mark set ${toString cfg.fwmark}
                    # proxy udp traffic
                    ip protocol udp ip daddr ${cfg.subnet} tproxy ip to :${toString cfg.udpTo} meta mark set ${toString cfg.fwmark}
                  }

                  chain output {
                    type route hook output priority mangle
                    policy accept

                    # bypass processed outbound
                    meta mark ${toString cfg.rtmark} return

                    # mark default outbound
                    ip protocol { tcp, udp } ip daddr ${cfg.subnet} meta mark set ${toString cfg.fwmark}
                  }
                ''
            )
          ];
        };
      };
    };

    systemd.services.tproxy =
      let
        ip = lib.getExe' pkgs.iproute2 "ip";
      in
      {
        description = "Setup tproxy redirect";

        wantedBy = [ "multi-user.target" ];
        requires = [ "network-online.target" ] ++ cfg.after;
        after = [ "network-online.target" ] ++ cfg.after;

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;

          ExecStart = pkgs.writeShellScript "tproxy-start" ''
            ${ip} route add local default dev lo table ${toString cfg.table}
            ${ip} rule add fwmark ${toString cfg.fwmark} table ${toString cfg.table}
          '';

          ExecStop = pkgs.writeShellScript "tproxy-stop" ''
            ${ip} route flush table ${toString cfg.table}
            ${ip} rule del fwmark ${toString cfg.fwmark} table ${toString cfg.table}
          '';
        };
      };
  };
}
