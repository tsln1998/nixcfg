{ lib, tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/i18n"
      "hosts/_common/gui/display/sddm.nix"
      "hosts/_common/gui/desktop/plasma.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.);

  services.logind.settings.Login.IdleAction="ignore";
  services.logind.settings.Login.IdleActionSec=0;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleSuspendKey="ignore";
  services.logind.settings.Login.HandleHibernateKey="ignore";
  services.logind.settings.Login.KillUserProcesses = false;
  
  systemd.sleep.settings.Sleep.AllowSuspend="no";
  systemd.sleep.settings.Sleep.AllowHibernation="no";
  systemd.sleep.settings.Sleep.AllowHybridSleep="no";

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
