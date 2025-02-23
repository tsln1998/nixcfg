{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    pnpm
    yarn
  ];

  home.file.".npmrc".text = ''
    registry=https://mirrors.cloud.tencent.com/npm/
  '';
}
