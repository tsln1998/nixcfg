_: {
  programs.starship = {
    enable = true;
    settings = {
      package = {
        disabled = true;
      };
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = "❄️ ";
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
      env_var.ZMX_SESSION = {
        symbol = "🪄 ";
        format = "[$symbol$env_value]($style) ";
        description = "zmx session name";
        style = "bold magenta";
      };
    };
  };
}
