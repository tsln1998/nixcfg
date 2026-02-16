{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$super" = "SUPER";
    "$mod" = "ALT";

    bind = [
      "$super, W, killactive,"
      "$super, Q, exit,"
      "$super, V, togglefloating,"
      "$super, P, pseudo, # dwindle"
      "$super, J, togglesplit, # dwindle"
      "$super, F, fullscreen, 1"

      # Move focus with mainMod + arrow keys
      "$super, left, movefocus, l"
      "$super, right, movefocus, r"
      "$super, up, movefocus, u"
      "$super, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$super, 1, workspace, 1"
      "$super, 2, workspace, 2"
      "$super, 3, workspace, 3"
      "$super, 4, workspace, 4"
      "$super, 5, workspace, 5"
      "$super, 6, workspace, 6"
      "$super, 7, workspace, 7"
      "$super, 8, workspace, 8"
      "$super, 9, workspace, 9"
      "$super, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$super SHIFT, 1, movetoworkspace, 1"
      "$super SHIFT, 2, movetoworkspace, 2"
      "$super SHIFT, 3, movetoworkspace, 3"
      "$super SHIFT, 4, movetoworkspace, 4"
      "$super SHIFT, 5, movetoworkspace, 5"
      "$super SHIFT, 6, movetoworkspace, 6"
      "$super SHIFT, 7, movetoworkspace, 7"
      "$super SHIFT, 8, movetoworkspace, 8"
      "$super SHIFT, 9, movetoworkspace, 9"
      "$super SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$super, S, togglespecialworkspace, magic"
      "$super SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$super, mouse_down, workspace, e+1"
      "$super, mouse_up, workspace, e-1"
    ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$super, mouse:272, movewindow"
      "$super, mouse:273, resizewindow"
    ];
  };
}
