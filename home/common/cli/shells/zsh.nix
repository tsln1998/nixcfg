{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;

    initContent = ''
      # Opts
      setopt local_options nullglob
      unsetopt AUTO_CD

      # Bindings
      bindkey '^[[1;5C' forward-word  # Ctrl + right
      bindkey '^[[1;5D' backward-word # Ctrl + left

      # Load local profile files
      for profile in ~/.profile*.local; do
        source "$profile"
      done
    '';
  };
}
