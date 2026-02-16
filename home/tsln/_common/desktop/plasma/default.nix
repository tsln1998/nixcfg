{ tools, ... }:
{
  imports = tools.scan ./.;
  
  programs.plasma = {
    enable = true;
  };
}
