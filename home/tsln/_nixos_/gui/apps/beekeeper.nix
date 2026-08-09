{ pkgs, ... }:
let
  beekeeper-studio = pkgs.beekeeper-studio.overrideAttrs (oldAttrs: {
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
in
{
  home.packages = [
    beekeeper-studio
  ];
}
