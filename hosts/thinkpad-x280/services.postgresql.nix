{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    initialScript = pkgs.writeText "init-sql-script" ''
      alter user postgres with password 'postgres';
    '';
    ensureDatabases = [
      "bs-gy"
      "bs-pay"
      "bs-camunda"
    ];
  };

  services.postgresql = {
    enableTCPIP = true;
    authentication = ''
      host all all 0.0.0.0/0 md5
    '';
  };

  networking.firewall.allowedTCPPorts = [
    5432
  ];
}
