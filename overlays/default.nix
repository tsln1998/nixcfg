_: [
  (import ./pkgs/local.nix _)
  (import ./repos/nur.nix _)
  (import ./repos/agenix.nix _)
  (import ./repos/vscode.nix _)
  (import ./repos/rust.nix _)
  (import ./tweaks/upgrade/qq.nix _)
  (import ./tweaks/desktop/wayland.nix _)
  (import ./tweaks/desktop/shortcut.nix _)
]
