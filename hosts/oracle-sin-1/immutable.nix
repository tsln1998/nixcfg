_: {
  fileSystems."/persist" = {
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      {
        directory = "/etc/nixos";
        mode = "0755";
      }
      {
        directory = "/etc/ssh/keys";
        mode = "0755";
      }
      {
        directory = "/var/log";
        mode = "0755";
      }
      {
        directory = "/var/lib/nixos";
        mode = "0755";
      }
      {
        directory = "/var/lib/containers";
        mode = "0755";
      }
      {
        directory = "/var/lib/postgresql";
        user = "postgres";
        group = "postgres";
        mode = "0750";
      }
      {
        directory = "/var/lib/systemd/coredump";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/timers";
        mode = "0755";
      }
    ];
    files = [
      "/etc/machine-id"
    ]
    ++ [
      "/var/lib/systemd/random-seed"
    ];
  };
}
