{ inputs, ... }: final: prev: {
  repos = (prev.repos or {}) // {
    nur = (inputs.nur.overlays.default final prev).repos;
  };
}
