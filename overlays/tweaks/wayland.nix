_: final: prev: {
  beekeeper-studio = prev.beekeeper-studio.overrideAttrs (oldAttrs: {
    installPhase =
      builtins.replaceStrings
        [
          ''\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}''
        ]
        [
          ''\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=UseOzonePlatform --enable-wayland-ime=true}}''
        ]
        oldAttrs.installPhase;
  });

  jetbrains = prev.jetbrains // {
    datagrip = prev.jetbrains.datagrip.override {
      vmopts = final.lib.concatStringsSep "\n" [
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
    };
  };
}
