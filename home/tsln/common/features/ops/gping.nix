{pkgs,...}: {
  home.packages = [
    pkgs.gping
  ];

  home.shellAliases.ping = "gping";
}