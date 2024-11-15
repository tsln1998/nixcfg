{ lib
, system
, nixos-wsl
, withSpecialArgs
, ...
}: {
  nixosConfigurations = {
    wsl-dev = lib.nixosSystem {
      inherit system;
      specialArgs = withSpecialArgs system;
      modules = [
        nixos-wsl.nixosModules.default
        ../../../hosts/wsl-dev
        {
          networking.hostName = "wsl-dev";
        }
      ];
    };
  };
}
