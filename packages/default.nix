pkgs:
let
  inherit (pkgs) lib;
  inherit (pkgs.stdenv) hostPlatform;
in
{
  # OpenAI's terminal-based coding agent.
  codex = pkgs.callPackage ./codex { };

  # Managed npm package specifications.
  managed-npm = pkgs.callPackage ./managed-npm { };

  # Managed container image references.
  managed-registry = pkgs.callPackage ./managed-registry { };
}
// lib.optionalAttrs hostPlatform.isDarwin {
  # All-in-one collaboration suite.
  feishu = pkgs.callPackage ./feishu { };

  # Cross-platform proxy client based on ClashMeta.
  flclash = pkgs.callPackage ./flclash { };

  # macOS app cleaner and uninstaller.
  pearcleaner = pkgs.callPackage ./pearcleaner { };
}
// lib.optionalAttrs hostPlatform.isLinux {
  # Catppuccin color schemes for Konsole.
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };

  # On-device Pinyin inference runtime and SDK for Phono.
  fcitx5-phono-core = pkgs.callPackage ./fcitx5-phono-core { };

  # Local neural input methods for Fcitx5.
  fcitx5-phono-addons = pkgs.callPackage ./fcitx5-phono-addons { };

  # PhonoP2C W8A8 model files for local neural input.
  fcitx5-phono-model = pkgs.callPackage ./fcitx5-phono-model { };
}
