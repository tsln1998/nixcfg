{ lib, config, ... }:
let
  cfg = config.services.mihomo;
in
{
  options.services.mihomo.tproxyMode = lib.mkEnableOption ''
    necessary permission for Mihomo's systemd service for tproxy mode to function properly.

    Keep in mind, that you still need to enable tproxy mode manually in Mihomo's configuration
  '';

  config = lib.mkIf (cfg.enable && cfg.tproxyMode) {
    systemd.services.mihomo = {
      serviceConfig = {
        AmbientCapabilities = lib.mkForce "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE";
        CapabilityBoundingSet = lib.mkForce "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE";
        PrivateDevices = lib.mkForce false;
        PrivateUsers = lib.mkForce false;
        RestrictAddressFamilies = lib.mkForce "AF_INET AF_INET6 AF_NETLINK";
      };
    };
  };
}
