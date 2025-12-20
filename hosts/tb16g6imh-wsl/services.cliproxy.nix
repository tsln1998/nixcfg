{ pkgs, ... }:
{
  services.cliproxy = {
    enable = true;
    package = pkgs.additions.cliproxy-plus;
    settings = {
      remote-management = {
        allow-remote = true;
        secret-key = "unsecret";
      };
    };
  };
}
