{
  lib,
  ...
}:
{
  # Catppuccin
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "blue";

    cache = {
      enable = true;
    };
  };
}
