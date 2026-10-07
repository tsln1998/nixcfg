_: final: prev:
let
  inherit (prev.lib) versionAtLeast;

  pkgs' = import ../../packages final.pkgs;
  newest = p: p': if versionAtLeast p.version p'.version then p else p';
in
pkgs'
// {
  codex = newest pkgs'.codex prev.codex;
}
