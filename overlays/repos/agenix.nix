{ inputs, ... }: final: prev: {
  repos = (prev.repos or {}) // {
    agenix = inputs.agenix.overlays.default final prev;
  };
}
