{
  lib,
  pkgs,
  config,
  tools,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
  inherit (config.networking) firewall;
  inherit (config.services) tailscale;
  inherit (config.services.samba) package;
in
{
  imports = tools.scan ./.;

  # Secrets
  age.secrets."hosts/${hostName}/samba/password" = {
    file = relative "secrets/hosts/${hostName}/samba/password.age";
    mode = "0644";
  };

  # Avahi
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
    openFirewall = true;
    extraServiceFiles = {
      samba = ''
        <?xml version="1.0" standalone='no'?>
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name>MK's MiniPC</name>

          <service>
            <type>_smb._tcp</type>
            <port>445</port>
            <txt-record>u=samba</txt-record>
          </service>

          <service>
            <type>_device-info._tcp</type>
            <port>0</port>
            <txt-record>model=Macmini</txt-record>
          </service>
        </service-group>
      '';
    };
  };

  # Firewall
  networking.nftables = lib.optionalAttrs (firewall.enable && tailscale.enable) {
    enable = lib.mkForce true;
    tables = {
      tailscale = {
        # TCP   22: OpenSSH Server
        # TCP  139: NetBIOS Session
        # TCP  445: Microsoft Direct Host SMB
        # TCP 3702: Web Services Dynamic Discovery
        # UDP  137: NetBIOS Name Service
        # UDP  138: NetBIOS Datagram
        # UDP 5353: mDNS
        # UDP 5357: Web Services Dynamic Discovery
        family = "inet";
        content = ''
          chain input {
            type filter hook input priority -10; policy accept;

            iifname "${tailscale.interfaceName}" tcp dport 22 accept;
            iifname "${tailscale.interfaceName}" tcp dport { 139, 445, 3792 } drop;
            iifname "${tailscale.interfaceName}" udp dport { 137, 138, 5353, 5357 } drop;
          }
        '';
      };
    };
  };

  # Samba
  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
    openFirewall = true;

    settings = {
      global = {
        "multicast dns register" = "no";

        "valid users" = "samba";
        "force user" = "samba";
        "force group" = "samba";

        "create mask" = "0600";
        "directory mask" = "0700";

        "ea support" = "yes";
        "vfs objects" = "fruit streams_xattr";

        "fruit:aapl" = "yes";
        "fruit:copyfile" = "yes";
        "fruit:metadata" = "stream";
        "fruit:resource" = "stream";
      };
    };
  };

  # Users & Groups
  users.groups.samba = { };
  users.users.samba = {
    group = "samba";
    isSystemUser = true;
  };

  # Initial Password
  systemd.services.samba-mkpass = {
    description = "Auto-provision Samba user";
    before = [ "samba-smbd.service" ];
    path = [ package ];

    restartTriggers = [
      secrets."hosts/${hostName}/samba/password".file
    ];

    serviceConfig = {
      Type = "oneshot";
      LoadCredential = "password:${secrets."hosts/${hostName}/samba/password".path}";
    };

    script = ''
      IFS= read -r PASS < "$CREDENTIALS_DIRECTORY/password" || [ -n "$PASS" ]

      if pdbedit -L -u samba > /dev/null 2>&1; then
        (echo "$PASS"; echo "$PASS") | smbpasswd -s samba
      else
        (echo "$PASS"; echo "$PASS") | smbpasswd -s -a samba
      fi

      smbpasswd -e samba
    '';
  };

  # Start & Reload hooks
  environment.etc = {
    "samba/smb.conf" = {
      mode = lib.mkForce "0600";
      target = lib.mkForce "samba/smb.conf";
    };
  };

  systemd.services.samba-smbd = {
    after = lib.mkAfter [
      "samba-mkpass.service"
    ];
    requires = lib.mkAfter [
      "samba-mkpass.service"
    ];

    reloadTriggers = [
      "/etc/samba/smb.conf"
    ];
  };
}
