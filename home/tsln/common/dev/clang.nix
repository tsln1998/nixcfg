{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    clang
    # deps
    pkg-config
    postgresql
    sqlite
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = lib.concatStringsSep ":" [
      "${pkgs.openssl.dev}/lib/pkgconfig"
      "${pkgs.libmysqlclient.dev}/lib/pkgconfig"
    ];
  };
}
