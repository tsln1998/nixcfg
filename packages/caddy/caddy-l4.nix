{ pkgs, ... }:
let
  locked =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/4533d9293756b63904b7238acb84ac8fe4c8c2c4.tar.gz";
        sha256 = "1n33324pfdd57mk25kp6qnl78d3s53grmg0m2lsj0gknph8v9d5m";
      })
      {
        inherit (pkgs.stdenv.hostPlatform) system;
        inherit (pkgs) config;
      };
in
locked.caddy.withPlugins {
  plugins = [ "github.com/mholt/caddy-l4@v0.0.0-20260104223739-97fa8c1b6618" ];
  hash = "sha256-9tFRk+ULLh99eSPiNtiusH9yqcIJkVuJOEaeS43s8Tc=";
}
