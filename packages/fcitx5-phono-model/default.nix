{
  lib,
  fetchurl,
  linkFarm,
}:
let
  sources = builtins.fromJSON (builtins.readFile ./update.json);
in
linkFarm "fcitx5-phono-model-${sources.version}" (
  lib.mapAttrsToList (name: source: {
    inherit name;
    path = fetchurl {
      name = baseNameOf name;
      inherit (source) url hash;
    };
  }) sources.files
)
