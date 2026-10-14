{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # Use the GRUB 2 boot loader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        configurationLimit = 15;
      };
      efi = {
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  systemd = {
    tmpfiles = {
      rules = [
        "q /tmp 1777 root root 1d"
      ];
    };
  };
}
