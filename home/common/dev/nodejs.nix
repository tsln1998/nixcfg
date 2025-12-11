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
    corepack
  ];

  home.file = {
    ".npmrc" = {
      text = ''
        prefix=${homeDirectory}/.npm
      '';
    };
  };

  home.sessionPath = [
    "${homeDirectory}/.npm/bin"
  ];
}
