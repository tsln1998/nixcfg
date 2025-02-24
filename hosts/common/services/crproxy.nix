{ lib, ... }:
{
  services.crproxy = {
    enable = true;
    address = lib.mkDefault "127.0.0.1:18000";
  };
}
