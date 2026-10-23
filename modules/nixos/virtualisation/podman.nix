_: {
  virtualisation.podman.autoPrune.enable = true;
  virtualisation.podman.autoPrune.dates = "weekly";
  virtualisation.podman.autoPrune.flags = [
    "--all"
    "--volumes"
  ];
}
