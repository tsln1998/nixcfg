{...}:{
  programs.starship = {
    enable = true;
    settings = {
      git_status = {
        style = "red";
        ahead = "⇡ ";
        behind = "⇣ ";
        conflicted = " ";
        renamed = "»";
        deleted = "✘ ";
        diverged = "⇆ ";
        modified = "!";
        stashed = "≡";
        staged = "+";
        untracked = "?";
      };
    };
  };
}