{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  owner = "router-for-me";
  repo = "Cli-Proxy-API-Management-Center";
  pname = "cliproxy-management";
  version = "1.3.5";
  hash = "sha256-qci9Tu4zJ9in6Ol+5KC0Sa3usAu50tkWg6XhhtTOs2c=";
in
stdenvNoCC.mkDerivation rec {
  inherit pname version;

  src = fetchurl {
    inherit hash;
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/management.html";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out && cp $src $out/management.html
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "WebUI interface for managing CLI-Proxy-API, designed to simplify configuration modifications and runtime status monitoring";
    maintainers = [ ];
    license = licenses.mit;
  };
}
