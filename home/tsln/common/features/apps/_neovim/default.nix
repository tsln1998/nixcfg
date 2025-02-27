{ tools, ... }:
{
  imports = (tools.scan ./.) ++ [ (tools.module "<nixvim-home-manager>") ];

  programs.nixvim.enable = true;
  programs.nixvim.colorschemes.catppuccin.enable = true;

  home.shellAliases.vi = "nvim";
  home.shellAliases.vim = "nvim";
}
