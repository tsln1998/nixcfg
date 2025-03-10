{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.nezha-agent ];
}
