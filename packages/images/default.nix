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
  pname = "images";
  version = builtins.substring 0 10 (builtins.hashString "sha256" (builtins.toJSON images));

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    install -Dm644 ${./update.json} $out/share/images/update.json
  '';

  # Consumers use pkgs.images.<key>.{repo,tag,ref}.
  passthru = images;

  meta = {
    description = "Container image references managed by update.json";
    platforms = lib.platforms.all;
  };
}
