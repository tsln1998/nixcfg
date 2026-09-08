{pkgs,...}: {
  home.packages = [
    pkgs.repos.local.waku

    pkgs.ibm-plex
  ];
}