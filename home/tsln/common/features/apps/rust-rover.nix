{ pkgs, tools, ... }:
let
  repo = pkgs.jetbrains;
  app = repo.rust-rover;
  market = tools.module "<jetbrains-plugins>";
  plugins = market.${app.system}.${app.pname}.${app.version};
  bundled = [
    plugins."com.codeium.intellij"
  ];
in
{
  home.packages = with repo.plugins; [
    (addPlugins (app.override {
      vmopts = ''
        -Dawt.toolkit.name=WLToolkit
      '';
    }) bundled)
  ];
}
