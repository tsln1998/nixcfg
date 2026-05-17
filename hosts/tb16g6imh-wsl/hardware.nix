{ lib, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = "tsln";
  wsl.startMenuLaunchers = true;
  wsl.wslConf.interop.enabled = false;
  wsl.wslConf.interop.appendWindowsPath = false;
  wsl.wslConf.network.generateHosts = false;
  wsl.wslConf.network.generateResolvConf = false;

  boot.tmp.useTmpfs = true;

  hardware.graphics.enable = lib.mkForce false;
}
