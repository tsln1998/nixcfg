{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    alacritty.enable = lib.mkDefault true;
    alacritty.flavor = lib.mkDefault "mocha";

    ghostty.enable = lib.mkDefault true;
    ghostty.flavor = lib.mkDefault "mocha";
  };
}
