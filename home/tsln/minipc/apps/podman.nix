{ pkgs, ... }:
{
  services.podman = {
    enable = true;
    package = pkgs.podman;
    settings = {
      registries = {
        search = [
          "docker.io"
        ];
      };
    };
  };

  home.packages = [
    pkgs.podman-compose
  ];
}
