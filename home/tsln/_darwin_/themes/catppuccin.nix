{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    alacritty.enable = lib.mkDefault true;
    alacritty.flavor = lib.mkDefault "mocha";
  };
}
