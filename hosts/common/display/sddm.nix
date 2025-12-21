{ ... }:
{
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    autoNumlock = true;
  };
}
