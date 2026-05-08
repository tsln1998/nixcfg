{
  lib,
  pkgs,
  config,
  ...
}:
let
  comin = lib.getExe config.services.comin.package;
  jq = lib.getExe' pkgs.jq "jq";
  sleep = lib.getExe' pkgs.coreutils "sleep";
  shuf = lib.getExe' pkgs.coreutils "shuf";
  systemctl = lib.getExe' pkgs.systemd "systemctl";
in
{
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/tsln1998/nixcfg.git";
        branches.main.name = "main";
      }
    ];

    postDeploymentCommand = pkgs.writeShellScript "comin-reboot" ''
        if ${comin} status --json | ${jq} -e '.need_to_reboot' 2>/dev/null; then
          if ! ${sleep} $(${shuf} -i 30-300 -n 1); then
            echo "Warning: sleep failed, proceeding to reboot anyway" >&2
          fi
          ${systemctl} reboot
        fi
      '';
  };
}
