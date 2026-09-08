pkgs:
{
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  codex = pkgs.callPackage ./codex { };
  waku = pkgs.callPackage ./waku { };
  pen = pkgs.callPackage ./pen { };
}
