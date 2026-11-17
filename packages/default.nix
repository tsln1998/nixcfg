pkgs:
let
  inherit (pkgs) lib;
  inherit (pkgs.stdenv) hostPlatform;
in
{
  # OpenAI's terminal-based coding agent.
  codex = pkgs.callPackage ./codex { };

  keyring-rs = pkgs.callPackage ./keyring-rs { };

  # Managed npm package specifications.
  managed-npm = pkgs.callPackage ./managed-npm { };

  # Managed container image references.
  managed-registry = pkgs.callPackage ./managed-registry { };
}
// lib.optionalAttrs hostPlatform.isLinux {
  # Catppuccin color schemes for Konsole.
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
}
// lib.optionalAttrs (hostPlatform.isDarwin || (hostPlatform.isLinux && hostPlatform.isx86_64)) {
  # Another desktop dictionary, but way more faster and definition-rich
  aictionary = pkgs.callPackage ./aictionary { };
}
