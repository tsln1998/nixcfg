{ tools, ... }:
{
  imports = tools.scan ./.;

  # Wayland supported
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };
}
