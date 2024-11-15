{
  # output args
  lib
, nixos-wsl
, home-manager
, system
  # system args
, name
, specialArgs
, modules
, ...
}: lib.nixosSystem {
  inherit system specialArgs;

  modules = modules ++ (
    [
      # system configuration
      nixos-wsl.nixosModules.default
      {
        wsl.enable = lib.mkForce true;
        wsl.defaultUser = lib.mkDefault "nixos";
        networking.hostName = lib.mkForce name;
      }
      # host configuration
      (lib.relativeToRoot "hosts/${name}")
      # home-manager
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
      }
    ]
  );
}
