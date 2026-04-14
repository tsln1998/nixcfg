{ pkgs, ... }:
{
  home.packages = [
    pkgs.openssl
  ];

  programs.pkg-config = {
    enable = true;
    paths = [
      "${pkgs.openssl.dev}/lib/pkgconfig"
    ];
  };
}
