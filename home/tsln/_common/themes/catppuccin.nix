{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "latte";
    accent = lib.mkDefault "blue";

    bat.flavor = lib.mkDefault "mocha";
    eza.flavor = lib.mkDefault "mocha";
    zellij.flavor = lib.mkDefault "mocha";
    lazygit.flavor = lib.mkDefault "mocha";
    konsole.flavor = lib.mkDefault "mocha";
    starship.flavor = lib.mkDefault "mocha";
    atuin.flavor = lib.mkDefault "mocha";
    btop.flavor = lib.mkDefault "mocha";
    delta.flavor = lib.mkDefault "mocha";
    fzf.flavor = lib.mkDefault "mocha";
    helix.flavor = lib.mkDefault "mocha";
    yazi.flavor = lib.mkDefault "mocha";
    zsh-syntax-highlighting.flavor = lib.mkDefault "mocha";

    cache = {
      enable = true;
    };
  };
}
