{ lib, ... }:
{
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = lib.mkDefault false;
      update_check = false;
    };
  };
}
