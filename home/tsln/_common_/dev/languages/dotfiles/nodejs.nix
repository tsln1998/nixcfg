{
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;
in
{
  home.file = {
    ".npmrc" = {
      text = ''
        prefix=${homeDirectory}/.npm
        registry=https://mirrors.cloud.tencent.com/npm/
      '';
    };
  };
  home.file = {
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
