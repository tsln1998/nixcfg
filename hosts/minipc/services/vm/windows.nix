{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  iso = pkgs.fetchurl {
    url = "https://github.com/netbootxyz/netboot.xyz/releases/download/3.0.2/netboot.xyz-multiarch.iso";
    hash = "sha256-LZmdF7v4iRKOEbfdaE824updTeJ0xqTeTPwEjBlLCOI=";
  };
  connection = "qemu:///system";
  installer = false;
in
{
  virtualisation.libvirt.connections.${connection}.domains = [
    {
      definition = inputs.nixvirt.lib.domain.writeXML (
        let
          base = inputs.nixvirt.lib.domain.templates.windows {
            name = "Windows";
            uuid = "79e1671f-8cc7-4bda-8e64-612470f54421";

            vcpu = {
              count = 8;
            };
            memory = {
              count = 16;
              unit = "GiB";
            };

            install_vol = "${iso}";
            install_virtio = true;

            virtio_net = true;
            virtio_drive = true;
            virtio_video = true;

            net_iface_mac = "56:D3:2A:8E:71:05";

            nvram_path = "/var/lib/libvirt/qemu/nvram/Windows.fd";
          };
        in
        base
        // {
          devices =
            base.devices
            // {
              disk = base.devices.disk ++ [
                {
                  type = "block";
                  device = "disk";
                  driver = {
                    name = "qemu";
                    type = "raw";
                  };
                  source = {
                    dev = "/dev/mapper/pool-vmdk";
                  };
                  target = {
                    dev = "vda";
                    bus = "virtio";
                  };
                }
              ];

              channel = [ ];
              redirdev = [ ];
            }
            // (lib.optionalAttrs installer {
              graphics = [
                {
                  type = "egl-headless";
                  gl = {
                    rendernode = "/dev/dri/renderD128";
                  };
                }
                {
                  type = "vnc";
                  port = -1;
                  autoport = true;
                  listen = {
                    type = "address";
                    address = "0.0.0.0";
                  };
                }
              ];

              audio = {
                id = 1;
                type = "none";
              };
            });
        }
      );
      active = true;
      restart = true;
    }
  ];
}
