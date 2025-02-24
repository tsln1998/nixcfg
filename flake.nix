{
  nixConfig = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-systems.url = "github:nix-systems/default-linux";

    nixpkgs-nur.url = "github:nix-community/NUR";
    nixpkgs-nur.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/2411.6.0";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.systems.follows = "nixpkgs-systems";
    agenix.inputs.home-manager.follows = "home-manager";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

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
      # load packages
      packages = nixpkgs.lib.genAttrs (import nixpkgs-systems) (
        system: import ./packages nixpkgs.legacyPackages.${system}
      );
      # load tools
      tools = import ./tools (with self; with nixpkgs; { inherit inputs outputs lib; });
    in
    {
      inherit overlays;
      inherit packages;
      #
      # NixOS Modules
      #
      nixosModules = import ./modules/nixos;
      #
      # NixOS Configurations
      #
      nixosConfigurations = {
        # ThinkBook 16+ G6 IMH (WSL)
        "tb16g6imh-wsl" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos
            ./hosts/tb16g6imh-wsl
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # ThinkPad X280
        "thinkpad-x280" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos
            ./hosts/thinkpad-x280
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # Oracle Cloud Singapore
        "oci-sg-1" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/nixos
            ./hosts/oci-sg-1
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # VMware
        "vmware" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos
            ./hosts/vmware
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
      };
      #
      # Home Manager Modules
      #
      homeManagerModules = import ./modules/home-manager;
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
              ./modules/home-manager
              ./home/tsln/tb16g6imh-wsl
            ];
            extraSpecialArgs = with self; {
              inherit inputs outputs tools;
            };
          };
          # ThinkPad X280
          "tsln@thinkpad-x280" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs.x86_64-linux;
            modules = [
              ./modules/home-manager
              ./home/tsln/thinkpad-x280
            ];
            extraSpecialArgs = with self; {
              inherit inputs outputs tools;
            };
          };
          # Oracle Cloud Singapore
          "tsln@oci-sg-1" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs.aarch64-linux;
            modules = [
              ./modules/home-manager
              ./home/tsln/oci-sg-1
            ];
            extraSpecialArgs = with self; {
              inherit inputs outputs tools;
            };
          };
          # VMware
          "tsln@vmware" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs.x86_64-linux;
            modules = [
              ./modules/home-manager
              ./home/tsln/vmware
            ];
            extraSpecialArgs = with self; {
              inherit inputs outputs tools;
            };
          };
        };
    };
}
