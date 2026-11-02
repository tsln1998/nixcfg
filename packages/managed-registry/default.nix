{
  lib,
  stdenvNoCC,
}:
let
  # Single source of truth, see update.json and update.py in this directory.
  images = lib.mapAttrs (_: image: {
    inherit (image) repo tag;
    ref = "${image.repo}:${image.tag}";
  }) (builtins.fromJSON (builtins.readFile ./update.json));
in
stdenvNoCC.mkDerivation {
  pname = "managed-registry";
  version = builtins.substring 0 10 (builtins.hashString "sha256" (builtins.toJSON images));

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    install -Dm644 ${./update.json} $out/share/managed-registry/update.json
  '';

  # Consumers use pkgs.managed-registry.<key>.{repo,tag,ref}.
  passthru = images;

  meta = {
    description = "Container image references managed by update.json";
    platforms = lib.platforms.all;
  };
}
