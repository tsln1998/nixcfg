{ ... }:
{
  services.redis.servers.default = {
    enable = true;
    bind = "0.0.0.0";
    port = 6379;
    settings = {
      protected-mode = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [
    6379
  ];
}
