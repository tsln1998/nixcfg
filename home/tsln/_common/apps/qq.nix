{ pkgs, ... }:
{
  home.packages = [
    (pkgs.repos.nur.xddxdd.qq.override {
      xorg = pkgs.xorg // {
        libXdamage = pkgs.libxdamage;
      };
    })
  ];
}
