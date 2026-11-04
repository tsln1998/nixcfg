pkgs: {
  # OpenAI's terminal-based coding agent.
  codex = pkgs.callPackage ./codex { };

  # Catppuccin color schemes for Konsole.
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };

  # On-device Pinyin inference runtime and SDK for Phono.
  fcitx5-phono-core = pkgs.callPackage ./fcitx5-phono-core { };

  # Local neural input methods for Fcitx5.
  fcitx5-phono-addons = pkgs.callPackage ./fcitx5-phono-addons { };

  # PhonoP2C W8A8 model files for local neural input.
  fcitx5-phono-model = pkgs.callPackage ./fcitx5-phono-model { };

  # Managed npm package specifications.
  managed-npm = pkgs.callPackage ./managed-npm { };

  # Managed container image references.
  managed-registry = pkgs.callPackage ./managed-registry { };
}
