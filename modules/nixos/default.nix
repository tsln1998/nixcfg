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
    outputs.overlays.agenix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "litestream-0.3.13"
  ];
}
