{ inputs, ... }:
final: _: {
  repos = {
    # Unstable nixpkgs
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) config;
      inherit (final.stdenv.hostPlatform) system;
    };

    # NUR packages
    nur = (inputs.nixpkgs-nur.overlays.default final _).nur.repos;

    # LLM packages
    llm-agents = inputs.llm-agents.packages.${final.stdenv.hostPlatform.system};

    # Local packages
    additions = import ../packages final.pkgs;
  };
}
