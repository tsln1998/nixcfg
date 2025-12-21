{
  lib,
  ...
}:
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "latte";
    accent = lib.mkDefault "sky";

    cache = {
      enable = true;
    };
  };
}
