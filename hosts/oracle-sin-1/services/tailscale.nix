_: {
  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
      exit = {
        enable = true;
      };
      relay = {
        enable = true;
      };
    };
  };
}
