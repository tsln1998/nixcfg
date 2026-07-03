_: [
  (import ./repos/unstable.nix _)
  (import ./repos/agenix.nix _)
  (import ./repos/rust.nix _)
  (import ./pkgs/local.nix _)
  (import ./pkgs/claude.nix _)
  (import ./pkgs/codex.nix _)
]
