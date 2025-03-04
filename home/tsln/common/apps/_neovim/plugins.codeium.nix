{ lib, pkgs, ... }:
{
  programs.nixvim.plugins.codeium-nvim = {
    enable = true;

    settings = {
      virtual_text = {
        enabled = true;
      };
      tools = {
        curl = lib.getExe pkgs.curl;
        gzip = lib.getExe pkgs.gzip;
        uname = lib.getExe' pkgs.coreutils "uname";
        uuidgen = lib.getExe' pkgs.util-linux "uuidgen";
      };
    };
  };
}
