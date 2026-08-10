{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    plasma.enable = lib.mkDefault true;
    fcitx5.enable = lib.mkDefault true;
    wallpaper.enable = lib.mkDefault true;

    konsole.enable = lib.mkDefault true;
    konsole.flavor = lib.mkDefault "mocha";
  };
}
