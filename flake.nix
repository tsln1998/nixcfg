{
  nixConfig = {
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-systems.url = "github:nix-systems/default-linux";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/2411.6.0";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix/e600439ec4c273cf11e06fe4d9d906fb98fa097c";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.systems.follows = "nixpkgs-systems";
    agenix.inputs.home-manager.follows = "home-manager";

    jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";
    jetbrains-plugins.inputs.nixpkgs.follows = "nixpkgs-unstable";
    jetbrains-plugins.inputs.systems.follows = "nixpkgs-systems";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-systems,
      home-manager,
      ...
    }@inputs:
    let
      # load overlays
      overlays = import ./overlays (with self; { inherit inputs outputs; });
      # load tools
      tools = import ./tools (with self; with nixpkgs; { inherit inputs outputs lib; });
    in
    {
      inherit overlays;
      #
      # NixOS Modules
      #
      nixosModules = (import ./modules/nixos) // (import ./modules/common);
      #
      # NixOS Configurations
      #
      nixosConfigurations = {
        # ThinkBook 16+ G6 IMH (WSL)
        "tb16g6imh-wsl" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/tb16g6imh-wsl
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
      };
      #
      # Home Manager Modules
      #
      homeManagerModules = (import ./modules/home-manager) // (import ./modules/common);
      #
      # Home Manager Standalone Configrations
      #
      homeConfigurations =
        let
          # generate packages for all systems
          pkgs = nixpkgs.lib.genAttrs (import nixpkgs-systems) (system: import nixpkgs { inherit system; });
        in
        {
          # ThinkBook 16+ G6 IMH (WSL)
          "tsln@tb16g6imh-wsl" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs.x86_64-linux;
            modules = [
              ./home/tsln/tb16g6imh-wsl
            ];
            extraSpecialArgs = with self; {
              inherit inputs outputs tools;
            };
          };
        };
    };
}
