{
  lib,
  stdenvNoCC,
}:
let
  # Single source of truth, see update.json and update.py in this directory.
  extensions = lib.mapAttrs (_: extension: {
    inherit (extension) name version;
    spec = "npm:${extension.name}@${extension.version}";
  }) (builtins.fromJSON (builtins.readFile ./update.json));
in
stdenvNoCC.mkDerivation {
  pname = "pi-extensions";
  version = builtins.substring 0 10 (builtins.hashString "sha256" (builtins.toJSON extensions));

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    install -Dm644 ${./update.json} $out/share/pi-extensions/update.json
  '';

  # Consumers use pkgs.pi-extensions.<key>.spec.
  passthru = extensions;

  meta = {
    description = "pi extension npm specs managed by update.json";
    platforms = lib.platforms.all;
  };
}
