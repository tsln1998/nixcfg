_: {
  programs.zsh = {
    enable = true;
    autocd = false;
    defaultKeymap = "emacs";

    initContent = ''
      setopt nullglob

      # Ctrl + Left/Right
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word

      # Load local profile
      for profile in ~/.config/profile.d/*.sh; do
        test -f "$profile" && source "$profile"
      done
    '';
  };
}
