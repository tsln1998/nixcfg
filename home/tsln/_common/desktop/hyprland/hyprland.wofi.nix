{ ... }:
{
  programs.wofi = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$super, R, exec, wofi --show drun"
    ];
  };
}
