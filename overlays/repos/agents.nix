{ inputs, ... }: final: prev: {
  repos = (prev.repos or { }) // {
    agents = (inputs.agents.overlays.shared-nixpkgs final prev).llm-agents;
  };
}
