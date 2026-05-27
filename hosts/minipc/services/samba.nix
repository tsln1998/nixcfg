{
  lib,
  pkgs,
  utils,
  config,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  disk = "7a411e69-f00f-441c-b987-49ce26341b81";
  service = "samba-smbd.service";
  mountPath = "/mnt/hdd";
  mountUnit = "${utils.escapeSystemdPath mountPath}.mount";
  devicePath = "/dev/disk/by-uuid/${disk}";
  deviceUnit = "${utils.escapeSystemdPath devicePath}.device";
in
{
  services = {
    samba = {
      enable = true;
      package = pkgs.samba4Full;
      smbd.enable = true;
      nmbd.enable = false;
      winbindd.enable = false;

      settings = {
        global = {
          "multicast dns register" = "no";

          "ea support" = "yes";
          "vfs objects" = "fruit streams_xattr";

          "fruit:aapl" = "yes";
          "fruit:copyfile" = "yes";
        };

        "Time Machine" = {
          "path" = "${mountPath}/.time-machine";
          "browseable" = "yes";
          "read only" = "no";
          "valid users" = "samba";
          "force user" = "samba";
          "force group" = "samba";

          "fruit:metadata" = "stream";
          "fruit:resource" = "stream";

          "fruit:time machine" = "yes";
          "fruit:time machine max size" = "1000G";

          "create mask" = "0600";
          "directory mask" = "0700";
        };
      };
    };

    samba-wsdd = {
      enable = true;
    };
  };

  users = {
    users = {
      samba = {
        group = "samba";
        isSystemUser = true;
      };
    };

    groups = {
      samba = {
      };
    };
  };

  systemd = {
    mounts = [
      {
        description = "Mount mobile HDD for Samba shares";
        what = devicePath;
        where = mountPath;
        type = "btrfs";
        options = "defaults,nofail,compress=zstd:3,autodefrag,noatime,commit=60";

        bindsTo = [ deviceUnit ];
        after = [ deviceUnit ];
        wantedBy = [ deviceUnit ];
      }
    ];

    services = {
      samba-prepare = {
        description = "Prepare Samba share directories";
        after = [ mountUnit ];
        requires = [ mountUnit ];
        before = [ service ];
        wantedBy = [ mountUnit ];
        path = [ pkgs.coreutils ];

        serviceConfig = {
          Type = "oneshot";
        };

        script = ''
          install -d -m 0700 -o samba -g samba ${config.services.samba.settings."Time Machine".path}
        '';
      };

      samba-mkpass = {
        description = "Auto-provision Samba user";
        after = [ mountUnit ];
        requires = [ mountUnit ];
        before = [ service ];
        wantedBy = [ mountUnit ];
        path = [ config.services.samba.package ];

        restartTriggers = [
          secrets."hosts/${hostName}/smbpasswd".file
        ];

        serviceConfig = {
          Type = "oneshot";
          LoadCredential = "passwd:${secrets."hosts/${hostName}/smbpasswd".path}";
        };

        script = ''
          IFS= read -r PASS < "$CREDENTIALS_DIRECTORY/passwd" || [ -n "$PASS" ]

          if pdbedit -L -u samba > /dev/null 2>&1; then
            (echo "$PASS"; echo "$PASS") | smbpasswd -s samba
          else
            (echo "$PASS"; echo "$PASS") | smbpasswd -s -a samba
          fi

          smbpasswd -e samba
        '';
      };

      samba-smbd = {
        wantedBy = lib.mkForce [ mountUnit ];
        after = lib.mkAfter [
          mountUnit
          "samba-prepare.service"
          "samba-mkpass.service"
        ];
        requires = [
          mountUnit
          "samba-prepare.service"
          "samba-mkpass.service"
        ];
        bindsTo = [ mountUnit ];
        partOf = lib.mkAfter [ mountUnit ];
      };

      samba-wsdd = {
        wantedBy = lib.mkForce [ mountUnit ];
        after = lib.mkAfter [
          mountUnit
          service
        ];
        requires = [
          mountUnit
          service
        ];
        bindsTo = [
          mountUnit
          service
        ];
        partOf = lib.mkAfter [
          mountUnit
          service
        ];
      };
    };
  };
}
