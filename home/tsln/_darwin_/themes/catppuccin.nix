{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    ghostty.enable = lib.mkDefault true;
    ghostty.flavor = lib.mkDefault "mocha";
  };
}
