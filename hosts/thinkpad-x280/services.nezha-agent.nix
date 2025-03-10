{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  nezha-agent = lib.getExe pkgs.unstable.nezha-agent;
in
{
  systemd.services.nezha-agent = {
    description = "Nezha agent service";
    after = [
      "network.target"
    ];
    requires = [
      "network.target"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "simple";
      ExecStart = lib.concatStringsSep " " [
        nezha-agent
        "--config"
        secrets."hosts/${hostName}/nezha-agent.yaml".path
      ];
      Restart = "on-failure";
    };
  };
}
