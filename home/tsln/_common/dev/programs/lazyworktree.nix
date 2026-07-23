{... }:
{
  programs.lazyworktree = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      worktree_dir = "$LWT_REPO_PATH/.worktree";
      auto_refresh = false;
      disable_pr = true;
    };
  };

  programs.git = {
    ignores = [
      ".worktree"
    ];
  };
}
