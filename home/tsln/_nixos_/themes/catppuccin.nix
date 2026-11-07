{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    # Plasma Workspace
    plasma.enable = lib.mkDefault true;

    # Plasma Wallpaper
    wallpaper.enable = lib.mkDefault true;

    # Fcitx
    fcitx5.enable = lib.mkDefault true;

    # Konsole
    konsole.enable = lib.mkDefault true;
    konsole.flavor = lib.mkDefault "mocha";

    # Alacritty
    alacritty.enable = lib.mkDefault true;
    alacritty.flavor = lib.mkDefault "mocha";
  };
}
