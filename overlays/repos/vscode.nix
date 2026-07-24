{ inputs, ... }: final: prev: {
  repos = (prev.repos or {}) // {
    vscode = inputs.vscode.overlays.default final prev;
  };
}
