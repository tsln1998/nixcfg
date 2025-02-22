{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # NixOS 24.11 with hyprland 0.45.x has some bugs with Xwayland
    package = pkgs.unstable.hyprland;
  };
}
