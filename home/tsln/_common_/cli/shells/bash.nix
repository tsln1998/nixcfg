_: {
  programs.bash = {
    enable = true;

    initExtra = ''
      # Load local profile
      for profile in ~/.config/profile.d/*.sh; do
        test -f "$profile" && source "$profile"
      done
    '';
  };
}
