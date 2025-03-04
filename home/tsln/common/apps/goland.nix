{ pkgs, tools, ... }:
let
  repo = pkgs.unstable.jetbrains;
  app = repo.goland;
  market = tools.module "<jetbrains-plugins>";
  plugins = market.${app.system}.${app.pname}.${app.version};
  bundled = [
    plugins."com.codeium.intellij"
  ];
in
{
  home.packages = with repo.plugins; [
    (addPlugins app bundled)
  ];
}
