{ ... }:
{
  wsl.enable = true;
  wsl.defaultUser = "tsln";
  wsl.startMenuLaunchers = true;
  wsl.wslConf.network.generateResolvConf = false;

  boot.tmp.useTmpfs = true;
}
