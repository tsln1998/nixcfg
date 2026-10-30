{
  lib,
}:
lib.mapAttrs (
  _: image:
  {
    inherit (image) repo tag;
    ref = "${image.repo}:${image.tag}";
  }
) (builtins.fromJSON (builtins.readFile ./update.json))
