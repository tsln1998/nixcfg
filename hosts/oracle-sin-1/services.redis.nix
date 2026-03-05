{ ... }:
{
  virtualisation.oci-containers.containers.redis = {
    image = "docker.io/redis:8-alpine";
    volumes = [
      "redis:/data"
    ];
  };
}
