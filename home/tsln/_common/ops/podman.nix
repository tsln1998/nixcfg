{ pkgs, lib, ... }:
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
    pkgs.docker-client
    pkgs.podman-compose
  ];

  home.activation.enablePodmanSocket = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/systemd/user/sockets.target.wants"
    $DRY_RUN_CMD ln -sfv "$HOME/.nix-profile/share/systemd/user/podman.socket" "$HOME/.config/systemd/user/sockets.target.wants/podman.socket"
    $DRY_RUN_CMD "${pkgs.systemd}/bin/systemctl" --user daemon-reload || true
  '';

  home.sessionVariables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };
}
