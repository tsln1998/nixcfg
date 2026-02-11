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
    ]
    ++ [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
    ];
    files = [
      "/etc/machine-id"
    ]
    ++ [
      "/var/lib/systemd/random-seed"
    ];
  };
}
