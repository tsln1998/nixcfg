_: {
  programs.starship = {
    enable = true;
    settings = {
      package = {
        disabled = true;
      };
      nix_shell = {
        format = "via [$symbol]($style)";
      };
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
