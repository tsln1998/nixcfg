{ config, pkgs, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.cliproxy = {
    enable = true;
    package = pkgs.additions.cliproxy-plus;
    settings = {
      remote-management = {
        allow-remote = true;
        secret-key = "unsecret";
      };
    };
    settingsFile = secrets."hosts/${hostName}/cliproxy.yaml".path;
  };
}
