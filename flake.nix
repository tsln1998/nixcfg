{
  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];

    extra-substituters = [
      "https://numtide.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-nur.url = "github:nix-community/NUR";
    nixpkgs-nur.inputs.nixpkgs.follows = "nixpkgs";

    nixos-systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "nixos-systems";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.systems.follows = "nixos-systems";
    agenix.inputs.home-manager.follows = "home-manager";

    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    llm-agents.url = "github:numtide/llm-agents.nix";
    llm-agents.inputs.nixpkgs.follows = "nixpkgs-unstable";
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
      pkgsFor =
        (nixpkgs.lib.genAttrs (flake-utils.lib.defaultSystems) (
          system:
          import nixpkgs {
            inherit system overlays;
            config = {
              allowUnfree = true;
            };
          }
        ))
        // {
          # Cross System
          x86_64-w64-mingw32 = import nixpkgs {
            inherit overlays;
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              allowUnsupportedSystem = true;
            };
            crossSystem = {
              config = "x86_64-w64-mingw32";
            };
          };
        };
    in
    {
      #
      # Packages
      #
      packages = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system: import ./packages pkgsFor.${system}
      );
      #
      # devShells
      #
      devShells = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system: import ./shells pkgsFor.${system}
      );
    }
    // {
      #
      # NixOS Modules
      #
      nixosModules = {
        default = import ./modules/nixos;
      };
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
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # ThinkBook 16+ G6 IMH
        "tb16g6imh" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/tb16g6imh
          ];
          specialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # Oracle Cloud Singapore
        "oracle-sin-1" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/oracle-sin-1
          ];
          specialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # Oracle Cloud India 1
        "oracle-bom-1" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/oracle-bom-1
          ];
          specialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # Oracle Cloud USA Phoenix 1
        "oracle-phx-1" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/oracle-phx-1
          ];
          specialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
      };
      #
      # Home Manager Modules
      #
      homeModules = {
        default = import ./modules/home;
      };
      #
      # Home Manager Standalone Configrations
      #
      homeConfigurations = {
        # ThinkBook 16+ G6 IMH (WSL)
        "tsln@tb16g6imh-wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./home/tsln/tb16g6imh-wsl
          ];
          extraSpecialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # ThinkBook 16+ G6 IMH (VMware)
        "tsln@tb16g6imh" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./home/tsln/tb16g6imh
          ];
          extraSpecialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # Oracle Cloud Singapore
        "tsln@oracle-sin-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-linux;
          modules = [
            ./home/tsln/oracle-sin-1
          ];
          extraSpecialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # Oracle Cloud India 1
        "tsln@oracle-bom-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-linux;
          modules = [
            ./home/tsln/oracle-bom-1
          ];
          extraSpecialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
        # Oracle Cloud USA Phoenix 1
        "tsln@oracle-phx-1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./home/tsln/oracle-phx-1
          ];
          extraSpecialArgs = with self; {
            inherit
              inputs
              outputs
              overlays
              tools
              ;
          };
        };
      };
    };
}
