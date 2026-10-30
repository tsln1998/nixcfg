_:
{
  # Hourly GitOps deploy
  system.autoUpgrade = {
    enable = true;

    # A bare flake ref resolves to the default branch (main) at each run;
    # input versions come from the repo's flake.lock only.
    flake = "github:tsln1998/nixcfg";

    # Never update flake inputs or channels on the host.
    upgrade = false;

    # Hourly trigger, randomized by 15min so hosts don't act at the same moment.
    dates = "hourly";
    randomizedDelaySec = "15min";

    # Reboot only when kernel, initrd or kernel modules changed, and only when
    # the post-build time check falls inside this local-time window.
    allowReboot = true;
    rebootWindow = {
      lower = "02:59";
      upper = "04:59";
    };
  };

  # Deprioritize builds/closure fetches so unattended deploys don't compete with
  # interactive work on small hosts. "batch" is milder than "idle", which can
  # starve updates; 5 is a low-but-not-extreme best-effort I/O weight.
  nix.daemonCPUSchedPolicy = "batch";
  nix.daemonIOSchedPriority = 5;
}
