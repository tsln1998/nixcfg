{ ... }:
{
  programs.kitty = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$super, T, exec, kitty"
    ];
  };
}
