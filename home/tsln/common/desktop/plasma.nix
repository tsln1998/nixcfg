{ tools, ... }:
{
  imports = [ (tools.module "<plasma-home-manager>") ];

  programs.plasma = {
    enable = true;
  };
}
