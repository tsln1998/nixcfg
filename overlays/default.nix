_: [
  (import ./repos/unstable.nix _)
  (import ./repos/agenix.nix _)
  (import ./repos/comin.nix _)
  (import ./repos/keyring.nix _)
  (import ./repos/vscode.nix _)
  (import ./repos/local.nix _)
  (import ./tweaks/shortcut.nix _)
  (import ./tweaks/wayland.nix _)
  (import ./tweaks/konsole.nix _)
  (import ./packages/android.nix _)
  (import ./bugfix/mcporter.nix _)
]
