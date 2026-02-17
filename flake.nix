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

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.systems.follows = "systems";
    agenix.inputs.home-manager.follows = "home-manager";

    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.inputs.home-manager.follows = "home-manager";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    catppuccin.url = "github:catppuccin/nix/release-25.11";
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
      pkgsFor = nixpkgs.lib.genAttrs (flake-utils.lib.defaultSystems) (
        system:
        import nixpkgs {
          inherit system overlays;
          config = {
            allowUnfree = true;
          };
        }
      );
      # make nixosSystem
      nixosSystem =
        { hostName, system, ... }@args:
        {
          name = hostName;
          value = nixpkgs.lib.nixosSystem (
            {
              inherit system;
              modules = [
                ./hosts/${hostName}
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
            // (builtins.removeAttrs args [
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
                ./home/${userName}/${hostName}
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
            // (builtins.removeAttrs args [
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
        system: import ./packages pkgsFor.${system}
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
      # Home Manager Modules
      #
      homeModules = {
        default = import ./modules/home;
      };
    }
    // {
      #
      # NixOS Configurations
      #
      nixosConfigurations = builtins.listToAttrs [
        # ThinkBook 16+ G6 IMH (WSL)
        (nixosSystem {
          hostName = "tb16g6imh-wsl";
          system = "x86_64-linux";
        })
        # ThinkBook 16+ G6 IMH
        (nixosSystem {
          hostName = "tb16g6imh";
          system = "x86_64-linux";
        })
        # Oracle Cloud Singapore 1
        (nixosSystem {
          hostName = "oracle-sin-1";
          system = "aarch64-linux";
        })
        # Oracle Cloud Singapore 2
        (nixosSystem {
          hostName = "oracle-sin-2";
          system = "aarch64-linux";
        })
      ];
      #
      # Home Manager Standalone Configrations
      #
      homeConfigurations = builtins.listToAttrs [
        # ThinkBook 16+ G6 IMH (WSL)
        (homeConfiguration {
          userName = "tsln";
          hostName = "tb16g6imh-wsl";
          system = "x86_64-linux";
        })
      ];
    };
}
