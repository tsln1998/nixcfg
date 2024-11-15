{ lib
, system
, nixos-wsl
, withSpecialArgs
, ...
}: {
  nixosConfigurations = {
    vm-dev = lib.nixosSystem {
      inherit system;
      specialArgs = withSpecialArgs system;
      modules = [
        ../../../hosts/vm-dev
        {
          networking.hostName = "vm-dev";
        }
      ];
    };
  };
}
