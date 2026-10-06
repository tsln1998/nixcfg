{
  pkgs,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;
in
{
  home = {
    packages = with pkgs; [
      nodejs
      yarn
      pnpm
    ];

    file = {
      ".npmrc" = {
        text = ''
          prefix=${homeDirectory}/.npm
          registry=https://mirrors.cloud.tencent.com/npm/
          update-notifier=false
        '';
      };

      ".config/pnpm/config.yaml" = {
        text = ''
          updateNotifier: false
        '';
      };
    };

    sessionPath = [
      "${homeDirectory}/.npm/bin"
      "${homeDirectory}/.local/share/pnpm/bin"
    ];
  };
}
