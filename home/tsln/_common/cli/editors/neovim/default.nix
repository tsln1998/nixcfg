{ lib, tools, ... }:
{
  imports = tools.scan ./.;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = lib.mkDefault true;
  programs.neovim.viAlias = lib.mkDefault true;
  programs.neovim.vimAlias = lib.mkDefault true;
  programs.neovim.withRuby = lib.mkDefault false;
  programs.neovim.withPython3 = lib.mkDefault false;
  programs.neovim.withNodeJs = lib.mkDefault false;
}
