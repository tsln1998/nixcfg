{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;

    initContent = ''
      bindkey '^[[1;5C' forward-word  # Ctrl + right
      bindkey '^[[1;5D' backward-word # Ctrl + left
    '';
  };
}
