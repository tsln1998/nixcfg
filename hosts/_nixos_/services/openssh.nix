{ lib, ... }:
{
  services.openssh = {
    enable = true;
    extraConfig = lib.concatStringsSep "\n" [
      "ClientAliveInterval 30"
      "ClientAliveCountMax 10"
    ];
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/keys/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/keys/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
