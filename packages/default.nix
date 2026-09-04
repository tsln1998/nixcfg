pkgs:
{
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
}
// pkgs.lib.optionalAttrs (pkgs.stdenv.hostPlatform.system == "x86_64-linux") {
  pen = pkgs.callPackage ./pen { };
}
