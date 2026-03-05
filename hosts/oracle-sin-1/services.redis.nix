{ ... }:
{
  virtualisation.oci-containers.containers.redis = {
    image = "docker.io/redis:8-alpine";
    autoStart = true;
    volumes = [
      "redis:/data"
    ];
  };
}
