_: {
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.dates = "weekly";
  virtualisation.docker.autoPrune.flags = [
    "--all"
    "--volumes"
  ];
}
