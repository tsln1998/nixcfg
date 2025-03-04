{ outputs, tools, ... }:
{
  imports = tools.scan ./.;

  nix = {
    settings = {
      substituters = [
        "https://mirrors.sustech.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirror.iscas.ac.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
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
