{
  lib,
  stdenvNoCC,
  fetchzip,
}:
let
  owner = "catppuccin";
  repo = "konsole";
  name = "${owner}-${repo}";
  hashes = (builtins.fromJSON (builtins.readFile ./hashes.json)).konsole;
in
stdenvNoCC.mkDerivation {
  pname = name;
  inherit (hashes) version;

  src = fetchzip {
    name = "source";
    inherit (hashes) url hash;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out && cp $src/themes/* $out/
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}";
    description = "Soothing pastel theme for Konsole";
    maintainers = [ ];
    license = licenses.mit;
  };
}
