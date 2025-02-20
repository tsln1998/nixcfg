{ outputs, ... }:
{
  nix = {
    settings = {
      substituters = [
        "https://mirrors.cernet.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  nixpkgs.overlays = [
    outputs.overlays.unstable
  ];

  nixpkgs.config.allowUnfree = true;
}
