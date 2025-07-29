{ pkgs, ... }:
let
  crproxy = pkgs.additions.crproxy;
  procps = pkgs.procps;

  address = "127.0.0.1:60080";
in
{
  systemd.services.crproxy = {
    description = "CRProxy daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${crproxy}/bin/crproxy --address ${address}";
      ExecStop = "${procps}/bin/pkill crproxy";
      Restart = "on-failure";
    };
  };
}
