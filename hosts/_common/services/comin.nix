{ pkgs, ... }:
{
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/tsln1998/nixcfg.git";
        branches.main.name = "main";
      }
    ];
    postDeploymentCommand = pkgs.writers.writeBash "combin-reboot-if-need" ''
      KERNEL_INSTALL="$(readlink /nix/var/nix/profiles/system/kernel 2>/dev/null || true)"
      KERNEL_BOOTED="$(readlink /run/booted-system/kernel 2>/dev/null || true)"
      if [ "$KERNEL_INSTALL" != "$KERNEL_BOOTED" ]; then
        DELAY=$((15 + RANDOM % 600))
        echo "Kernel mismatch: $KERNEL_INSTALL != $KERNEL_BOOTED, rebooting in $DELAY seconds..."
        sleep $DELAY
        reboot
      fi
    '';
  };
}
