{ pkgs, ... }:
{
  services.cliproxy = {
    enable = true;
    package = pkgs.additions.cliproxy-plus;
    management = "unsecret";
    statistics = true;
  };
}
