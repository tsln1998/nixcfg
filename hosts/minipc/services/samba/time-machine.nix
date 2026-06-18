{
  pkgs,
  config,
  lib,
  utils,
  ...
}:
let
  inherit (lib) escapeShellArg;
  inherit (utils) escapeSystemdPath;

  name = "Time Machine";
  mount = "/mnt/hdd";
  subdir = ".time-machine";

  cfg = config.services.samba.settings.global // config.services.samba.settings.${name};
in
{
  services.samba.settings = {
    ${name} = {
      "path" = "${mount}/${subdir}";
      "browseable" = "yes";
      "available" = "no";
      "read only" = "no";

      "fruit:time machine" = "yes";
      "fruit:time machine max size" = "1000000000000";
    };
  };

  systemd.services =
    let
      svc = "samba-subdir-${escapeSystemdPath "${mount}/${subdir}"}";
    in
    {
      ${svc} = {
        after = [ "${escapeSystemdPath mount}.mount" ];
        requires = [ "${escapeSystemdPath mount}.mount" ];
        partOf = [ "${escapeSystemdPath mount}.mount" ];
        bindsTo = [ "${escapeSystemdPath mount}.mount" ];
        wantedBy = [ "${escapeSystemdPath mount}.mount" ];
        path = [
          pkgs.coreutils
          pkgs.crudini
        ];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;

          ExecStartPre = pkgs.writeShellScript "${name}-pre" (
            lib.optionalString (cfg ? path) ''
              install -d \
                ${lib.optionalString (cfg ? "directory mask") "-m ${escapeShellArg cfg."directory mask"}"} \
                ${lib.optionalString (cfg ? "force user") "-o ${escapeShellArg cfg."force user"}"} \
                ${lib.optionalString (cfg ? "force group") "-g ${escapeShellArg cfg."force group"}"} \
                ${cfg.path}
            ''
          );

          ExecStart = pkgs.writeShellScript "${svc}-start" ''
            crudini --set /etc/samba/smb.conf ${escapeShellArg name} available yes
          '';

          ExecStop = pkgs.writeShellScript "${svc}-stop" ''
            crudini --set /etc/samba/smb.conf ${escapeShellArg name} available no
          '';
        };
      };
    };
}
