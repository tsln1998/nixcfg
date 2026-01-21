{ lib, pkgs, ... }:
let
  release = pkgs.jetbrains.datagrip;
in
{
  home.packages = [
    (release.override {
      vmopts = lib.strings.concatStringsSep "\n" [
        # Increase Maximum Heap Size
        "-Xms1024m"
        "-Xmx2048m"
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
