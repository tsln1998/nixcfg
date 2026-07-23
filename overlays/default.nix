_: [
  (import ./repos/unstable.nix _)
  (import ./repos/nur.nix _)
  (import ./repos/agenix.nix _)
  (import ./repos/rust.nix _)
  (import ./repos/vscode.nix _)
  (import ./pkgs/local.nix _)
  (import ./tweaks/alternative/claude.nix _)
  (import ./tweaks/alternative/codex.nix _)
  (import ./tweaks/desktop/shortcut.nix _)
  (import ./tweaks/desktop/wayland.nix _)
]
