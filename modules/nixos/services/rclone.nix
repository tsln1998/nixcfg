{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.rclone;
  naming = name: "rclone-mount" + lib.optionalString (name != "") ("-" + name);
  mounts = lib.filterAttrs (name: conf: conf.enable) cfg.mounts;
in
{
  options.services.rclone = {
    enable = lib.mkEnableOption "rclone service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rclone;
    };

    mounts = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule (
          { lib, ... }:
          {
            options = {
              enable = lib.mkOption {
                type = lib.types.bool;
                default = true;
              };

              configFile = lib.mkOption {
                type = lib.types.path;
                description = "rclone.conf path";
              };

              remote = lib.mkOption {
                type = lib.types.str;
                description = "remote name";
              };

              subpath = lib.mkOption {
                type = lib.types.str;
                description = "remote subpath";
              };

              local = lib.mkOption {
                type = lib.types.str;
                description = "local mount path";
              };

              vfs-cache = {
                enable = lib.mkOption {
                  type = lib.types.bool;
                  default = true;
                };

                mode = lib.mkOption {
                  type = lib.types.enum [
                    "full"
                    "writes"
                    "minimal"
                    "off"
                  ];
                  default = "full";
                };

                max-age = lib.mkOption {
                  type = lib.types.str;
                  default = "1h";
                };

                max-size = lib.mkOption {
                  type = lib.types.str;
                  default = "32G";
                };

                poll-interval = lib.mkOption {
                  type = lib.types.str;
                  default = "1m";
                };

                write-back = lib.mkOption {
                  type = lib.types.str;
                  default = "5s";
                };
              };
            };
          }
        )
      );
      description = "Configuration of multiple `rclone mount` instances.";
      default = { };
    };
  };

  config = lib.mkIf (config.services.rclone.enable) {
    environment.systemPackages = [
      cfg.package
    ];

    systemd.services = lib.mapAttrs' (
      name: conf:
      lib.nameValuePair (naming name) {
        description = "rclone mount ${name}";

        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];

        serviceConfig = {
          LoadCredential = "rclone.conf:${conf.configFile}";

          ExecStartPre = lib.concatStringsSep " " [
            (lib.getExe' pkgs.coreutils "mkdir")
            "-p"
            conf.local
          ];

          ExecStart = lib.concatStringsSep " " (
            [ (lib.getExe' cfg.package "rclone") ]
            ++ [ "mount" ]
            ++ [
              "--no-checksum"
              "--no-modtime"
              "--no-seek"
            ]
            ++ [
              "--config"
              "\${CREDENTIALS_DIRECTORY}/rclone.conf"
            ]
            ++ (lib.optionals conf.vfs-cache.enable [
              "--vfs-cache-mode"
              conf.vfs-cache.mode
              "--vfs-cache-max-age"
              conf.vfs-cache.max-age
              "--vfs-cache-max-size"
              conf.vfs-cache.max-size
              "--vfs-cache-poll-interval"
              conf.vfs-cache.poll-interval
              "--vfs-write-back"
              conf.vfs-cache.write-back
            ])
            ++ [
              "${conf.remote}:${conf.subpath}"
              "${conf.local}"
            ]
          );

          ExecStartPost = pkgs.writeShellScript ((naming name) + "-check") ''
            for i in {1..15}; do
              ${lib.getExe' pkgs.utillinux "mountpoint"} -q ${conf.local} && break || sleep 1
            done
          '' ;

          ExecStop = lib.concatStringsSep " " [
            (lib.getExe' pkgs.fuse "fusermount")
            "-u"
            conf.local
          ];
        };
      }
    ) mounts;
  };
}
