{
  nixConfig = {
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://cache.garnix.io"
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nur.inputs.flake-parts.follows = "flake-parts";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-compat.url = "github:NixOS/flake-compat";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    systems.url = "github:nix-systems/triplet";
    hardware.url = "github:nixos/nixos-hardware";
    hardware.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.systems.follows = "systems";
    agenix.inputs.home-manager.follows = "home-manager";

    comin.url = "github:nlewo/comin/v0.12.0";
    comin.inputs.nixpkgs.follows = "nixpkgs";
    comin.inputs.flake-compat.follows = "flake-compat";
    comin.inputs.treefmt-nix.follows = "treefmt-nix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.inputs.home-manager.follows = "home-manager";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    keyring.url = "github:tsln1998/keyring-rs";
    keyring.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nix-homebrew.inputs.brew-src.follows = "homebrew";

    homebrew.url = "github:Homebrew/brew";
    homebrew.flake = false;

    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;

    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;

    homebrew-zuisong.url = "github:zuisong/homebrew-tap";
    homebrew-zuisong.flake = false;

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    agents.url = "github:numtide/llm-agents.nix";
    agents.inputs.nixpkgs.follows = "nixpkgs";
    agents.inputs.systems.follows = "systems";
    agents.inputs.flake-parts.follows = "flake-parts";
    agents.inputs.treefmt-nix.follows = "treefmt-nix";

    # TODO: wait for release-26.11
    catppuccin.url = "github:catppuccin/nix/9e84aa294455c58a1caba475902d06c1170ed5c1";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    vscode.url = "github:nix-community/nix-vscode-extensions";
    vscode.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-nixos,
      nixpkgs-darwin,
      nix-darwin,
      treefmt-nix,
      home-manager,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib.strings) toLower;
      # load tools
      tools = import ./tools (with self; with nixpkgs; { inherit inputs outputs lib; });
      # load overlays
      overlays = import ./overlays (with self; with nixpkgs; { inherit inputs outputs lib; });
      # select the channel-gated nixpkgs input for each host platform
      nixpkgsInputFor =
        system: if nixpkgs.lib.hasSuffix "-darwin" system then nixpkgs-darwin else nixpkgs-nixos;
      # load nixpkgs
      pkgsFor = nixpkgs.lib.genAttrs flake-utils.lib.defaultSystems (
        system:
        import (nixpkgsInputFor system) {
          inherit system overlays;
        }
      );
      # load formatter
      treefmtFor = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system: treefmt-nix.lib.evalModule pkgsFor.${system} ./formatter.nix
      );
      # make nixosSystem
      nixosSystem =
        { hostName, system, ... }@args:
        {
          name = hostName;
          value = nixpkgs-nixos.lib.nixosSystem (
            {
              inherit system;
              modules = [
                ./hosts/${toLower hostName}
                {
                  networking = {
                    inherit hostName;
                  };
                }
              ];
              specialArgs = with self; {
                inherit
                  inputs
                  outputs
                  overlays
                  tools
                  ;
              };
            }
            // (removeAttrs args [
              "hostName"
              "system"
            ])
          );
        };
      # make darwinSystem
      darwinSystem =
        { hostName, system, ... }@args:
        {
          name = hostName;
          value = nix-darwin.lib.darwinSystem (
            {
              inherit system;
              modules = [
                ./hosts/${toLower hostName}
                {
                  networking = {
                    inherit hostName;
                  };
                }
              ];
              specialArgs = with self; {
                inherit
                  inputs
                  outputs
                  overlays
                  tools
                  ;
              };
            }
            // (removeAttrs args [
              "hostName"
              "system"
            ])
          );
        };
      # make homeConfiguration
      homeConfiguration =
        {
          userName,
          hostName,
          system,
          ...
        }@args:
        {
          name = "${userName}@${hostName}";
          value = home-manager.lib.homeManagerConfiguration (
            {
              pkgs = pkgsFor.${system};
              modules = [
                ./home/${userName}/${toLower hostName}
              ];
              extraSpecialArgs = with self; {
                inherit
                  inputs
                  outputs
                  overlays
                  tools
                  ;
              };
            }
            // (removeAttrs args [
              "userName"
              "hostName"
              "system"
            ])
          );
        };
    in
    {
      #
      # Packages
      #
      packages = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        # local packages
        system: import ./packages pkgsFor.${system}
      );
      #
      # legacyPackages
      #
      legacyPackages = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        # nixpkgs with overlays
        system: pkgsFor.${system}
      );
      #
      # devShells
      #
      devShells = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system: import ./shells pkgsFor.${system}
      );
      #
      # NixOS Modules
      #
      nixosModules = {
        default = import ./modules/nixos;
      };
      #
      # Darwin Modules
      #
      darwinModules = {
        default = import ./modules/darwin;
      };
      #
      # Home Manager Modules
      #
      homeModules = {
        default = import ./modules/home;
      };
    }
    // {
      #
      # Formatter
      #
      formatter = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system: treefmtFor.${system}.config.build.wrapper
      );
      #
      # Checks
      #
      checks = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system:
        let
          packages = self.packages.${system};
          treefmt = treefmtFor.${system};
        in
        packages
        // {
          formatting = treefmt.config.build.check self;
        }
      );
    }
    // {
      #
      # NixOS Configurations
      #
      nixosConfigurations = builtins.listToAttrs [
        # Mini PC
        (nixosSystem {
          hostName = "minipc";
          system = "x86_64-linux";
        })
        # Oracle Cloud Singapore 1
        (nixosSystem {
          hostName = "oracle-sin-1";
          system = "aarch64-linux";
        })
        # Oracle Cloud USA Phoenix 1
        (nixosSystem {
          hostName = "oracle-phx-1";
          system = "x86_64-linux";
        })
      ];
      #
      # Nix Darwin Standalone Configurations
      #
      darwinConfigurations = builtins.listToAttrs [
        (darwinSystem {
          hostName = "mba";
          system = "aarch64-darwin";
        })
      ];
      #
      # Home Manager Standalone Configurations
      #
      homeConfigurations = builtins.listToAttrs [
        (homeConfiguration {
          userName = "tsln";
          hostName = "mba";
          system = "aarch64-darwin";
        })
      ];
    };
}
