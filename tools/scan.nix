{ lib, ... }:
path:
map (f: (path + "/${f}")) (
  builtins.attrNames (
    lib.attrsets.filterAttrs (
      name: type:
      (
        # include directory if default.nix exists
        type == "directory" && builtins.pathExists (path + "/${name}/default.nix")
      )
      || (
        # include .nix files and ignore default.nix
        (name != "default.nix") && (lib.strings.hasSuffix ".nix" name)
      )
    ) (builtins.readDir path)
  )
)
