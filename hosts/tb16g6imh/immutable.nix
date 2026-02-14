{ ... }:
{
  fileSystems."/persist" = {
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
    directories = [
      { directory = "/etc/ssh"; mode = "0755"; }
      { directory = "/etc/nixos"; mode = "0755"; }
      { directory = "/etc/NetworkManager/system-connections"; mode = "0755"; }
      { directory = "/var/log"; mode = "0755"; }
      { directory = "/var/lib/bluetooth"; mode = "0755"; }
      { directory = "/var/lib/nixos"; mode = "0755"; }
      { directory = "/var/lib/docker"; mode = "0755"; }
      { directory = "/var/lib/upower"; mode = "0755"; }
      { directory = "/var/lib/iwd"; mode = "0755"; }
      { directory = "/var/lib/systemd/coredump"; mode = "0755"; }
      { directory = "/var/lib/systemd/timers"; mode = "0755"; }
      { directory = "/var/lib/systemd/backlight"; mode = "0755"; }
      { directory = "/var/lib/NetworkManager"; mode = "0755"; }
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/sddm/state.conf"
      "/var/lib/systemd/random-seed"
    ];
  };
}
