{ lib, pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    package = pkgs.atuin;
    daemon = {
      enable = false;
    };
    settings = {
      auto_sync = lib.mkDefault false;
      update_check = false;
    };
  };
}
