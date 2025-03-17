{...}: {
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers.emby = {
    serviceName = "emby";
    image = "linuxserver/emby:beta-version-4.9.0.42";
    ports = [
      "127.0.0.1:6084:8096"
    ];
    volumes = [
      "/tmp/emby:/config"
      "/mnt/alist:/data"
    ];
  };

  
}