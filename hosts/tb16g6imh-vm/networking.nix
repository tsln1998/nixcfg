{ lib, ... }:
{
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "tb16g6imh-vm";
}
