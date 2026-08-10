{
  pkgs,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;
in
{
  home.packages = with pkgs; [
    nodejs
    yarn
    pnpm
  ];

  home.file = {
    ".npmrc" = {
      text = ''
        prefix=${homeDirectory}/.npm
        registry=https://mirrors.cloud.tencent.com/npm/
      '';
    };

    ".config/pnpm/config.yaml" = {
      text = ''
        updateNotifier: false
      '';
    };
  };

  home.sessionPath = [
    "${homeDirectory}/.npm/bin"
    "${homeDirectory}/.local/share/pnpm/bin"
  ];
}
