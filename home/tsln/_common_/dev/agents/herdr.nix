{
  config,
  pkgs,
  lib,
  ...
}:
let
  # herdr 会在 Settings UI / `herdr config reset-keys` 里回写 config.toml，
  # 所以落盘的是可写副本而不是 /nix/store 路径。
  # 改完跑 `herdr server reload-config` 生效，`herdr config check` 验证。
  toml = pkgs.formats.toml { };

  # toml.generate 的输入要求是 JSON 兼容值（string/bool/float/attrset/list/null）。
  # 传路径字面量让 store 里保留原始文件名。
  configFile = toml.generate "herdr-config.toml" {
    onboarding = false;

    theme = {
      name = "catppuccin";
    };

    keys = {
      # 与 tmux 默认一致，无需改动：d detach、w picker、s goto、? help、
      # c/p/n 切换窗口、1..9、x kill-pane、S-x kill-window、z zoom、
      # hjkl focus-pane、tab 轮换窗格。

      # tmux 有、herdr 默认不同或未绑定。
      split_vertical = "prefix+%"; # tmux: C-b %   (herdr 默认 prefix+v)
      split_horizontal = "prefix+quote"; # tmux: C-b "   (默认 prefix+minus)
      rename_tab = "prefix+comma"; # tmux: C-b ,   (默认 prefix+shift+t)
      rename_workspace = "prefix+$"; # tmux: C-b $   (默认 prefix+shift+w)
      last_pane = "prefix+semicolon"; # tmux: C-b ;   (默认未绑定)
      previous_workspace = "prefix+("; # tmux: C-b (
      next_workspace = "prefix+)"; # tmux: C-b )
      swap_pane_up = "prefix+{"; # tmux: C-b {
      swap_pane_down = "prefix+}"; # tmux: C-b }

      # 本仓库 tmux extraConfig 的自定义绑定：
      # bind i swap-window -t -1 / bind o swap-window -t +1
      move_tab_previous = "prefix+i";
      move_tab_next = "prefix+o";

      # 避开 prefix+r —— 仓库里 bind r source-file 是重载配置。
      # herdr 默认 reload_config=prefix+shift+r、resize_mode=prefix+r，互换命名。
      reload_config = "prefix+r";
      resize_mode = "prefix+shift+r";

      # herdr 默认 prefix+o 已被 move_tab_next 占用。
      open_notification_target = "";
    };
  };
in
{
  home.packages = [
    pkgs.herdr
  ];

  # herdr 会自行回写，所以先复制出可写副本（store 路径是只读的）。
  home.activation.herdrConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    conf="${config.xdg.configHome}/herdr/config.toml"
    run mkdir -p "$(dirname "$conf")"
    run cp -f "${configFile}" "$conf"
    run chmod u+w "$conf"
  '';
}
