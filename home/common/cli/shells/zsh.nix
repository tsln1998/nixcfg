{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;

    initContent = ''
      # Opts
      unsetopt AUTO_CD

      # Bindings
      bindkey '^[[1;5C' forward-word  # Ctrl + right
      bindkey '^[[1;5D' backward-word # Ctrl + left

      # Load local zshrc
      if [ -f ~/.zshrc.local ]; then
        source ~/.zshrc.local
      fi
    '';
  };
}
