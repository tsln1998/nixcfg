_: [
  (import ./pkgs/unstable.nix _)
  (import ./pkgs/local.nix _)
  (import ./pkgs/zen.nix _)
  (import ./repos/nur.nix _)
  (import ./repos/agenix.nix _)
  (import ./repos/vscode.nix _)
  (import ./repos/llm-agents.nix _)
  (import ./tweaks/deprecated/libxdamage.nix _)
  (import ./tweaks/desktop/wayland.nix _)
  (import ./tweaks/desktop/shortcut.nix _)
]
