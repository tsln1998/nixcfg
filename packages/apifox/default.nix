{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "apifox";
  text = ''
    echo TODO
  '';
}
