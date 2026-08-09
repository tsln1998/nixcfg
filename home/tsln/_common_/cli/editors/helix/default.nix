{ tools, ... }:
{
  imports = tools.scan ./.;

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}
