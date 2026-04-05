{ lib, ... }:
{
  programs.atuin = {
    enable = true;
    daemon = {
      enable = false;
    };
    settings = {
      auto_sync = lib.mkDefault false;
      update_check = false;
    };
  };
}
