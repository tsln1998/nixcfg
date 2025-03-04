{ outputs, tools, ... }:
{
  imports = tools.scan ./.;

  nix = {
    settings = {
      substituters = [
        "https://mirrors.cernet.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
    };
  };

  nixpkgs.overlays = [
    outputs.overlays.unstable
    outputs.overlays.nur
    outputs.overlays.additions
    outputs.overlays.agenix
  ];

  nixpkgs.config.allowUnfree = true;
}
