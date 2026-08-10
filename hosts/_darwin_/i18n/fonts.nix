{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    monaspace
    nerd-fonts.monaspace
  ];
}
