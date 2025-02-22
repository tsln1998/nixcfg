{ tools, ... }:
{
  imports = [ (tools.module "<plasma-home-manager>") ];

  programs.plasma = {
    enable = true;
    configFile = {
      "kwinrc"."Wayland"."InputMethod[$e]" = "$HOME/.nix-profile/share/applications/fcitx5-wayland-launcher.desktop";
      "kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;
    };
  };
}
