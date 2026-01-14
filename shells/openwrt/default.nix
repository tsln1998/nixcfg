# An environment for build OpenWrt
#
pkgs:
pkgs.mkShell {
  name = "openwrt-devshell";
  packages = with pkgs; [
    binutils
    bzip2
    coreutils
    diffutils
    findutils
    flex
    gawk
    gcc
    getopt
    gnugrep
    gnumake
    libc.dev
    libz.dev
    ncurses.dev
    perl
    pkg-config
    python3
    rsync
    subversion
    unzip
    wget
    which
  ];
}
