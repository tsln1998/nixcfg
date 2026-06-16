_: [
  (import ./pkgs/local.nix _)
  (import ./pkgs/claude.nix _)
  (import ./repos/agenix.nix _)
  (import ./repos/rust.nix _)
]
