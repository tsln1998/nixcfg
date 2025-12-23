{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  owner = "router-for-me";
  repo = "Cli-Proxy-API-Management-Center";
  pname = "cliproxy-management";
  version = "1.1.8";
  hash = "sha256-rVLmXH0wR9nQNgRJNoN8ldJmaitqXeBKX19l85uGEug=";
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
