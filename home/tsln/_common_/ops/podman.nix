{ pkgs, lib, ... }:
let
  DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
in
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

  # Enable podman docker compatibly
  home.packages = [
    pkgs.podman
    pkgs.podman-compose
    pkgs.docker-client
  ];

  home.activation.enablePodmanSocket = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/systemd/user/sockets.target.wants"
    $DRY_RUN_CMD ln -sfv "$HOME/.nix-profile/share/systemd/user/podman.socket" "$HOME/.config/systemd/user/sockets.target.wants/podman.socket"
    $DRY_RUN_CMD "${pkgs.systemd}/bin/systemctl" --user daemon-reload || true
  '';

  home.sessionVariables = {
    inherit DOCKER_HOST;
  };

  systemd.user.sessionVariables = {
    inherit DOCKER_HOST;
  };

  # Enable podman auto purge
  systemd.user.services."podman-resource-prune" = {
    Unit = {
      Description = "Podman Rootless Storage and Resource Prune Service";
      Documentation = [ "man:podman-system-prune(1)" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.podman}/bin/podman system prune --all --volumes --force";
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };

  systemd.user.timers."podman-resource-prune" = {
    Unit = {
      Description = "Periodic Podman Resource Prune Timer";
    };
    Timer = {
      OnCalendar = "Sun *-*-* 03:30:00";
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
