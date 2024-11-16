{ mylib, pkgs, ... }:
{
  imports =
    [ ./users.nix ]
    ++ map mylib.relativeToRoot [
      "modules/base"
      "modules/base/server"
      "modules/shells"
      "modules/utils"
    ];

  system.stateVersion = "24.05";
}
