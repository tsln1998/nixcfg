_: final: prev: {
  repos = (prev.repos or { }) // {
    local = import ../../packages final.pkgs;
  };
}
