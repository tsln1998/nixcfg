{ pkgs, ... }:
{
  home.packages = [
    pkgs.openssl
  ];

  programs.pkgconfig = {
    enable = true;
    paths = [
      "${pkgs.openssl.dev}/lib/pkgconfig"
    ];
  };
}
