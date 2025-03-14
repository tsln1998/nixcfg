{
  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/10069ef4cf863633f57238f179a0297de84bd8d3";
    nixpkgs-systems.url = "github:nix-systems/default-linux";

    nixpkgs-nur.url = "github:nix-community/NUR";
    nixpkgs-nur.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/2411.6.0";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "nixpkgs-systems";

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

    catppuccin.url = "github:catppuccin/nix/v1.2.1";

    jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";
    jetbrains-plugins.inputs.nixpkgs.follows = "nixpkgs-unstable";
    jetbrains-plugins.inputs.systems.follows = "nixpkgs-systems";
    jetbrains-plugins.inputs.flake-utils.follows = "flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
      ...
    }@inputs:
    let
      # load tools
      tools = import ./tools (with self; with nixpkgs; { inherit inputs outputs lib; });
      # load overlays
      overlays = import ./overlays (with self; with nixpkgs; { inherit inputs outputs lib; });
      # load nixpkgs
      pkgsFor = nixpkgs.lib.genAttrs (flake-utils.lib.defaultSystems) (
        system:
        import nixpkgs {
          inherit system overlays;
          config = {
            allowUnfree = true;
          };
        }
      );
    in
    {
      #
      # Inherit outputs
      #
      inherit overlays;
    }
    // (flake-utils.lib.eachDefaultSystem (system: {
      #
      # Packages
      #
      packages = import ./packages pkgsFor.${system};
      #
      # devShells
      #
      devShells = import ./shells pkgsFor.${system};
    }))
    // {
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
        # ThinkBook 16+ G6 IMH (VMware)
        "tb16g6imh-vm" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos
            ./hosts/tb16g6imh-vm
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
        "oracle-sin-1" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/nixos
            ./hosts/oracle-sin-1
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # Oracle Cloud India 1
        "oracle-bom-1" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/nixos
            ./hosts/oracle-bom-1
          ];
          specialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # Oracle Cloud USA Phoenix 1
        "oracle-phx-1" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos
            ./hosts/oracle-phx-1
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
      homeConfigurations = {
        # ThinkBook 16+ G6 IMH (WSL)
        "tsln@tb16g6imh-wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./modules/home-manager
            ./home/tsln/tb16g6imh-wsl
          ];
          extraSpecialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # ThinkBook 16+ G6 IMH (VMware)
        "tsln@tb16g6imh-vm" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./modules/home-manager
            ./home/tsln/tb16g6imh-vm
          ];
          extraSpecialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # ThinkPad X280
        "tsln@thinkpad-x280" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./modules/home-manager
            ./home/tsln/thinkpad-x280
          ];
          extraSpecialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # Oracle Cloud Singapore
        "tsln@oracle-sin-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-linux;
          modules = [
            ./modules/home-manager
            ./home/tsln/oracle-sin-1
          ];
          extraSpecialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # Oracle Cloud India 1
        "tsln@oracle-bom-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-linux;
          modules = [
            ./modules/home-manager
            ./home/tsln/oracle-bom-1
          ];
          extraSpecialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
        # Oracle Cloud USA Phoenix 1
        "tsln@oracle-phx-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./modules/home-manager
            ./home/tsln/oracle-phx-1
          ];
          extraSpecialArgs = with self; {
            inherit inputs outputs tools;
          };
        };
      };
    };
}
