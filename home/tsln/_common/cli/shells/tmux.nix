{ pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    mouse = true;
    baseIndex = 1;

    plugins = with pkgs.tmuxPlugins; [
      # 底部状态栏
      power-theme
    ];

    extraConfig = ''
      # 重排窗口
      set -g renumber-windows on

      # 状态栏置于底部
      set-option -g status-position bottom

      # R 重载配置
      bind r source-file ~/.config/tmux/tmux.conf

      # I 往前移动
      bind i swap-window -t -1\; select-window -t -1

      # O 往后移动
      bind o swap-window -t +1\; select-window -t +1
    '';
  };

  home.sessionVariables = {
    TMUX_TMPDIR = lib.mkForce "/tmp";
  };
}
