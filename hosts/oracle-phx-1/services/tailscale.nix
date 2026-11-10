_: {
  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
      ssh = {
        enable = true;
      };
      exit = {
        enable = true;
      };
      relay = {
        enable = true;
      };
    };
  };
}
