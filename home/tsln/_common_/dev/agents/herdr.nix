{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) optionals;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  toml = pkgs.formats.toml { };

  conf = toml.generate "herdr-config.toml" {
    onboarding = false;

    theme = {
      name = "catppuccin";
    };

    keys = {
      # tmux C-b %
      split_vertical = "prefix+%";
      # tmux C-b "
      split_horizontal = "prefix+quote";
      # tmux C-b ,
      rename_tab = "prefix+comma";
      # tmux C-b $
      rename_workspace = "prefix+$";
      # tmux C-b ;
      last_pane = "prefix+semicolon";
      # tmux C-b (
      previous_workspace = "prefix+(";
      # tmux C-b )
      next_workspace = "prefix+)";
      # tmux C-b {
      swap_pane_up = "prefix+{";
      # tmux C-b }
      swap_pane_down = "prefix+}";

      # tmux C-i/o
      move_tab_previous = "prefix+i";
      move_tab_next = "prefix+o";

      # tmux C-r
      reload_config = "prefix+r";
      resize_mode = "prefix+shift+r";

      # 排除冲突键
      open_notification_target = "";
    };
  };
in
{
  home.packages = [
    pkgs.herdr
  ]
  ++ (optionals isLinux [
    pkgs.wl-clipboard
  ]);

  home.activation.herdrConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    conf="${config.xdg.configHome}/herdr/config.toml"
    run mkdir -p "$(dirname "$conf")"
    run cp -f "${conf}" "$conf"
    run chmod u+w "$conf"
  '';
}
