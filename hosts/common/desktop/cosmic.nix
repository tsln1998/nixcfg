{ tools, ... }:
{
  imports = [ (tools.module "<cosmic-nixos>") ];
  
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
}
