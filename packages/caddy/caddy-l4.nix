{ pkgs, ... }:
pkgs.caddy.withPlugins {
  plugins = [ "github.com/mholt/caddy-l4@v0.0.0-20260104223739-97fa8c1b6618" ];
  hash = "sha256-+8gihZALxygPkb5nWbsVBDqcS2G4yK/E6qOpbRBRLEk=";
}
