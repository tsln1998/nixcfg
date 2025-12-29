{ pkgs, ... }:
let
  repo = pkgs.unstable;
  market = pkgs.jetbrains-plugins;
  release = repo.jetbrains.idea;
in
{
  home.packages = [
    (repo.jetbrains.plugins.addPlugins
      (release.override {
        vmopts = ''
          -Dawt.toolkit.name=WLToolkit
        '';
      })
      (
        map (id: market.${release.pname}.${release.version}.${id}) [
          "com.anthropic.code.plugin"
        ]
      )
    )
  ];
}
