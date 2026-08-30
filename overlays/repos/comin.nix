{ inputs, ... }: final: prev: {
  repos = (prev.repos or { }) // {
    comin = inputs.comin.overlays.default final prev;
  };
}
