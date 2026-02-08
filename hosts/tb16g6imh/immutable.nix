{ ... }:
{
  fileSystems."/persist" = {
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/home"
    ]
    ++ [
      "/etc/ssh"
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
    ]
    ++ [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/docker"
      "/var/lib/upower"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      {
        directory = "/var/lib/private";
        mode = "0700";
      }
    ];
    files = [
      "/etc/machine-id"
    ]
    ++ [
      "/var/lib/sddm/state.conf"
      "/var/lib/systemd/random-seed"
    ];
  };
}
