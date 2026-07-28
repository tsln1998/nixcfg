_: {
  fileSystems."/persist" = {
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
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
        directory = "/etc/NetworkManager/system-connections";
        mode = "0755";
      }
      {
        directory = "/var/tmp";
        mode = "0777";
      }
      {
        directory = "/var/cache/colord";
        mode = "0755";
      }
      {
        directory = "/var/cache/cups";
        mode = "0755";
      }
      {
        directory = "/var/cache/fwupd";
        mode = "0755";
      }
      {
        directory = "/var/cache/fwupdmgr";
        mode = "0755";
      }
      {
        directory = "/var/cache/samba";
        mode = "0755";
      }
      {
        directory = "/var/cache/tailsale";
        mode = "0755";
      }
      {
        directory = "/var/log/journal";
        mode = "0755";
      }
      {
        directory = "/var/lib/bluetooth";
        mode = "0755";
      }
      {
        directory = "/var/lib/nixos";
        mode = "0755";
      }
      {
        directory = "/var/lib/dnsmasq";
        mode = "0755";
      }
      {
        directory = "/var/lib/fwupd";
        mode = "0755";
      }
      {
        directory = "/var/lib/tailscale";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/coredump";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/timers";
        mode = "0755";
      }
      {
        directory = "/var/lib/NetworkManager";
        mode = "0755";
      }
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/systemd/random-seed"
      "/var/lib/sddm/state.conf"
    ];
  };
}
