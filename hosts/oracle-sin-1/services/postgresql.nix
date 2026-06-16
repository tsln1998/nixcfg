_: {
  # PostgreSQL Service
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    enableJIT = true;

    dataDir = "/var/lib/postgresql";

    authentication = ''
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };
}
