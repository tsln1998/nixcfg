{ lib, ... }:
{
  programs.atuin = {
    enable = true;
    daemon = {
      enable = true;
    };
    settings = {
      auto_sync = lib.mkDefault false;
      update_check = false;
    };
  };
}
