{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
      ];

      debug = {
        disable_logs = false;
      };
      xwayland = {
        enabled = true;
      };
      bind = [
        "SUPER, F5, exec, hyprctl reload"
        "SUPER, R, exec, wofi -S drun"
        "SUPER, B, exec, waybar"
        "SUPER, T, exec, alacritty"
      ];
    };
  };

  programs.waybar = {
    enable = true;
  };

  programs.wofi = {
    enable = true;
    settings = {
      image_size = 32;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      matching = "multi-contains";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = { };
  };
}
