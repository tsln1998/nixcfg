{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [
        pkgs.fcitx5-rime
        pkgs.fcitx5-nord
      ]
      ++ [
        pkgs.rime-cli
        pkgs.rime-data
        pkgs.rime-zhwiki
      ];

      waylandFrontend = true;
    };
  };

  # Plasma virutal keyboard
  programs.plasma.configFile.kwinrc = {
    Wayland = {
      VirtualKeyboardEnabled = {
        value = true;
      };
      InputMethod = {
        shellExpand = true;
        value = "$HOME/.nix-profile/share/applications/fcitx5-wayland-launcher.desktop";
      };
    };
  };

  # Wayland supported
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };
}
