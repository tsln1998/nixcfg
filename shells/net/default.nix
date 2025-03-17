# An environment for debugging network information
#
pkgs:
pkgs.mkShell {
  name = "net-devshell";
  packages = with pkgs; [
    nali
    q
    mtr
    gping
    whois
    traceroute
  ];
}
