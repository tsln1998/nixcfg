{
  outputs,
  tools,
  ...
}:
{
  imports = tools.scan ./.;
  nix = {
    settings = {
      substituters = [
        "https://mirrors.cernet.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      trusted-users = [
        "@wheel"
      ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 31d";
      persistent = true;
    };
  };

  nixpkgs.overlays = outputs.overlays;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
}
