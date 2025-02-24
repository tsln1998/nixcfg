{ outputs, tools, ... }:
{
  imports = tools.scan ./.;

  nix = {
    settings = {
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
  ];

  nixpkgs.config.allowUnfree = true;
}
