{ lib, tools, ... }:
{
  imports = (
    map tools.relative [
      "<catppuccin-home-manager>"
    ]
  );

  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "latte";

    fcitx5 = {
      enable = false;
    };
  };
}
