{ config, ... }:
{
  services.dolt.instances.main = {
    port = 33066;
    dataDir = "${config.home.homeDirectory}/.dolt";
    autoStart = true;
  };
}
