{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    enable = true;
    autoEnable = false;

    flavor = lib.mkDefault "latte";
    accent = lib.mkDefault "blue";

    wallpaper.enable = lib.mkDefault true;
    
    bat.enable = lib.mkDefault true;
    bat.flavor = lib.mkDefault "mocha";
    eza.enable = lib.mkDefault true;
    eza.flavor = lib.mkDefault "mocha";
    k9s.enable = lib.mkDefault true;
    k9s.flavor = lib.mkDefault "mocha";
    tmux.enable = lib.mkDefault true;
    tmux.flavor = lib.mkDefault "mocha";
    zellij.enable = lib.mkDefault true;
    zellij.flavor = lib.mkDefault "mocha";
    lazygit.enable = lib.mkDefault true;
    lazygit.flavor = lib.mkDefault "mocha";
    starship.enable = lib.mkDefault true;
    starship.flavor = lib.mkDefault "mocha";
    atuin.enable = lib.mkDefault true;
    atuin.flavor = lib.mkDefault "mocha";
    btop.enable = lib.mkDefault true;
    btop.flavor = lib.mkDefault "mocha";
    delta.enable = lib.mkDefault true;
    delta.flavor = lib.mkDefault "mocha";
    fzf.enable = lib.mkDefault true;
    fzf.flavor = lib.mkDefault "mocha";
    helix.enable = lib.mkDefault true;
    helix.flavor = lib.mkDefault "mocha";
    yazi.enable = lib.mkDefault true;
    yazi.flavor = lib.mkDefault "mocha";
    alacritty.enable = lib.mkDefault true;
    alacritty.flavor = lib.mkDefault "mocha";
    zsh-syntax-highlighting.enable = lib.mkDefault true;
    zsh-syntax-highlighting.flavor = lib.mkDefault "mocha";

    cache = {
      enable = true;
    };
  };
}
