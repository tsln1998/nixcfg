{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  systemd.services.rrc = {
    description = "RRC Notify";
    documentation = [ "https://github.com/tsln1998/rrc" ];
    requires = [ "network-online.target" ];
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.additions.github-rrc}";
      EnvironmentFile = secrets."hosts/${hostName}/rrc.env".path;
      DynamicUser = true;
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
