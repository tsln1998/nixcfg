{ lib, pkgs, ... }:
let
  repo = pkgs.repos.unstable;
  release = repo.jetbrains.idea;
in
{
  home.packages = [
    (release.override {
      vmopts = lib.strings.concatStringsSep "\n" [
        # Increase Maximum Heap Size
        "-Xms2048m"
        "-Xmx4096m"
        # Garbage Collection Tuning
        "-XX:+UseParallelGC"
        "-XX:ParallelGCThreads=4"
        # Enable Wayland Support
        "-Dawt.toolkit.name=WLToolkit"
        # Network Tuning
        "-Djava.net.preferIPv4Stack=true"
        # Disable Updates
        "-Dide.no.platform.update=true"
      ];
    })
  ];
}
