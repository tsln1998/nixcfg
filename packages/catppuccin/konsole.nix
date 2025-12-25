{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
let 
  owner = "catppuccin";
  repo = "konsole";
  name = "${owner}-${repo}";
  rev = "3b64040e3f4ae5afb2347e7be8a38bc3cd8c73a8";
  hash = "sha256-d5+ygDrNl2qBxZ5Cn4U7d836+ZHz77m6/yxTIANd9BU=";
in
stdenvNoCC.mkDerivation {
  pname = name;
  version = builtins.substring 0 6 rev;

  src = fetchFromGitHub {
    inherit owner repo;
    inherit rev hash;
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
