{ mylib, pkgs, ... }: {
  imports = [
    ./users.nix
  ] ++ map mylib.relativeToRoot [
    "modules/base"
    "modules/base/server"
    "modules/devel"
    "modules/devel/nix"
    "modules/devel/go"
    "modules/shells"
    "modules/utils"
  ];

  system.stateVersion = "24.05";
}
