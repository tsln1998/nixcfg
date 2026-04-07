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
    llm-agents = (inputs.llm-agents.overlays.default final _).llm-agents;

    # Zen packages
    zen = inputs.zen.packages.${final.stdenv.hostPlatform.system};

    # vscode packages
    vscode = (inputs.vscode.overlays.default final _).vscode-marketplace-release;

    # Local packages
    additions = import ../packages final.pkgs;
  };
}
