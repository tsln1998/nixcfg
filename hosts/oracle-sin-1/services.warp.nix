_: {
  virtualisation.oci-containers.containers.warp = {
    image = "caomingjun/warp:slim-2026.3.846.0-2.12.0";

    ports = [
      "127.0.0.1:1080:1080"
    ];

    capabilities = {
      MKNOD = true;
      NET_ADMIN = true;
      AUDIT_WRITE = true;
    };

    volumes = [
      "warp:/var/lib/cloudflare-warp"
    ];

    extraOptions = [
      "--dns=1.1.1.1"
      "--dns=1.0.0.1"
      "--device-cgroup-rule=c 10:200 rwm"
      "--sysctl=net.ipv6.conf.all.disable_ipv6=0"
      "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
    ];
  };
}
