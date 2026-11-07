_: _: prev:
let
  inherit (prev.lib) versionAtLeast;

  pkgs' = import ../../packages prev;
  newest = p: p': if versionAtLeast p.version p'.version then p else p';
in
pkgs'
// {
  codex = newest pkgs'.codex prev.codex;
}
