{ pkgs, ... }:
{
  home.packages = [
    (pkgs.nur.repos.xddxdd.qq.override {
      xorg = pkgs.xorg // {
        libXdamage = pkgs.libxdamage;
      };
    })
  ];
}
