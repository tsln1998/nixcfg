# An environment for debugging crproxy
#
pkgs:
pkgs.mkShell {
  name = "crproxy-devshell";
  packages = [
    pkgs.additions.crproxy
  ];
}
