# An environment for network tools
#
pkgs:
pkgs.mkShell {
  name = "network-devshell";
  packages = with pkgs; [
    q
    nali
  ];
}
