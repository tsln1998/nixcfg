{
  inputs,
  pkgs,
  tools,
  ...
}:
let
  connection = "qemu:///system";
in
{
  imports = tools.scan ./.;

  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.libvirtd.qemu.runAsRoot = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  virtualisation.libvirtd.qemu.swtpm.package = pkgs.swtpm;
  virtualisation.libvirtd.extraConfig = ''
    firewall_backend = "none"
  '';

  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.package = pkgs.libvirt;
  virtualisation.libvirt.connections.${connection}.networks = [
    {
      definition = inputs.nixvirt.lib.network.writeXML (
        inputs.nixvirt.lib.network.templates.bridge {
          name = "default";
          uuid = "56451a4d-b594-4c0c-8272-6fe8f2f35e1d";
          subnet_byte = 199;
          dhcp_hosts = [
            {
              name = "Windows";
              mac = "56:D3:2A:8E:71:05";
              ip = "192.168.199.2";
            }
          ];
        }
      );
      active = true;
      restart = true;
    }
  ];

  networking.networkmanager.unmanaged = [
    "interface-name:virbr0"
  ];

  networking.firewall.trustedInterfaces = [
    "virbr0"
  ];

  systemd.services.rdp-socat = {
    description = "RDP port forward via socat";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.socat}/bin/socat \
          TCP-LISTEN:3389,reuseaddr,fork \
          TCP:192.168.199.2:3389
      '';

      Restart = "always";
      RestartSec = 2;

      DynamicUser = true;
      NoNewPrivileges = true;
    };
  };
}
