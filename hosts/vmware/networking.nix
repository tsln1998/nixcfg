{ lib, ... }:
{
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "vmware";
}
