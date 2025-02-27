{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nfs-utils
  ];

  services.rpcbind.enable = true;

  systemd = {
    mounts = [
      {
        type = "nfs";
        mountConfig = {
          Options = "noatime";
        };
        what = "192.168.64.240:/data";
        where = "/mnt/ssd";
      }
    ];
    automounts = [
      {
        wantedBy = [ "multi-user.target" ];
        automountConfig = {
          TimeoutIdleSec = "600";
        };
        where = "/mnt/ssd";
      }
    ];
  };
}
