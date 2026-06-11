_: {
  programs.zsh = {
    enable = true;
    autocd = false;
    defaultKeymap = "emacs";

    initContent = ''
      setopt local_options nullglob

      # Load local profile
      for profile in ~/.config/profile.d/*.sh; do
        test -f "$profile" && source "$profile"
      done
    '';
  };
}
