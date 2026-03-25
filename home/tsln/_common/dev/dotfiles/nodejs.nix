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

  home.sessionPath = [
    "${homeDirectory}/.npm/bin"
  ];
}
