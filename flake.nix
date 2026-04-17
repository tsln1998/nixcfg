{
  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    unstable.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "unstable";
    nur.inputs.flake-parts.follows = "flake-parts";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-compat.url = "github:NixOS/flake-compat";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-compat.follows = "flake-compat";

    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.systems.follows = "systems";
    agenix.inputs.home-manager.follows = "home-manager";

    comin.url = "github:nlewo/comin";
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

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    llm-agents.url = "github:numtide/llm-agents.nix";
    llm-agents.inputs.nixpkgs.follows = "unstable";
    llm-agents.inputs.flake-parts.follows = "flake-parts";
    llm-agents.inputs.systems.follows = "systems";
    llm-agents.inputs.treefmt-nix.follows = "treefmt-nix";

    zen.url = "github:youwen5/zen-browser-flake";
    zen.inputs.nixpkgs.follows = "nixpkgs";

    vscode.url = "github:nix-community/nix-vscode-extensions";
    vscode.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
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
      pkgsFor = nixpkgs.lib.genAttrs flake-utils.lib.defaultSystems (
        system:
        import nixpkgs {
          inherit system overlays;
          config = {
            allowUnfree = true;
          };
        }
      );
      treefmtFor = nixpkgs.lib.genAttrs (builtins.attrNames pkgsFor) (
        system: treefmt-nix.lib.evalModule pkgsFor.${system} ./formatter.nix
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
        # ThinkBook 16+ G6 IMH
        (nixosSystem {
          hostName = "tb16g6imh";
          system = "x86_64-linux";
        })
        # ThinkBook 16+ G6 IMH (WSL)
        (nixosSystem {
          hostName = "tb16g6imh-wsl";
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
        # Oracle Cloud USA Phoenix 1
        (nixosSystem {
          hostName = "oracle-phx-1";
          system = "x86_64-linux";
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
