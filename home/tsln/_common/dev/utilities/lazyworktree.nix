{ pkgs, ... }:
{
  home.packages = [
    pkgs.lazyworktree
  ];

  home.file = {
    ".config/lazyworktree/config.yaml" = {
      text = ''
        worktree_dir: $LWT_REPO_PATH/.worktrees
        auto_refresh: false
        disable_pr: true
      '';
    };
  };

  programs.git = {
    ignores = [
      ".worktrees"
    ];
  };
}
