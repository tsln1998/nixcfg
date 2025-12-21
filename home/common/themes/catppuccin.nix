{
  lib,
  config,
  pkgs,
  ...
}:
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
  };

  programs.plasma =
    let
      artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${config.catppuccin.flavor}";
      wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-mocha.png";
    in
    {
      workspace = {
        inherit wallpaper;
        lookAndFeel = "Catppuccin Frappe Blue";
      };
      kscreenlocker.appearance = {
        inherit wallpaper;
      };
    };

  home.packages = (
    lib.optionals config.programs.plasma.enable [
      pkgs.catppuccin-kde
    ]
  );
}
