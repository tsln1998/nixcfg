{ pkgs, ... }:
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
  home = {
    packages = [
      pkgs.podman
      pkgs.podman-compose
      pkgs.docker-client
    ];

    sessionVariables = {
      inherit DOCKER_HOST;
    };
  };

  # Take over the symlink previously created by enablePodmanSocket.
  xdg.configFile = {
    "systemd/user/sockets.target.wants/podman.socket" = {
      force = true;
    };
  };

  # Enable the API socket and periodic cleanup.
  systemd = {
    user = {
      sessionVariables = {
        inherit DOCKER_HOST;
      };

      sockets = {
        podman = {
          Unit = {
            Description = "Podman API Socket";
            Documentation = [ "man:podman-system-service(1)" ];
          };
          Socket = {
            ListenStream = "%t/podman/podman.sock";
            SocketMode = "0660";
          };
          Install = {
            WantedBy = [ "sockets.target" ];
          };
        };
      };

      services = {
        podman-resource-prune = {
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
      };

      timers = {
        podman-resource-prune = {
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
      };
    };
  };
}
