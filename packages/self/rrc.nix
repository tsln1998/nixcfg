{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc,
}:
let
  owner = "tsln1998";
  pname = "rrc";
  version = "0.0.2";

  # Select the appropriate binary based on system architecture
  src = fetchurl (
    if stdenv.hostPlatform.system == "x86_64-linux" then {
      url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}-v${version}-linux-amd64.tar.gz";
      sha256 = "sha256-ygAv3jS0dkNVMwiIc1NBPPU5r3inNSb9ulFgZ7S0wpU=";
    } else if stdenv.hostPlatform.system == "aarch64-linux" then {
      url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}-v${version}-linux-arm64.tar.gz";
      sha256 = "sha256-e7R2KpGdwsLGI1LS44B9DpF2qMhhhDDe1PKMIGQY/Yk=";
    } else throw "Unsupported system: ${stdenv.hostPlatform.system}"
  );
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gcc.cc.lib
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp ${pname}-v${version}-linux-amd64 $out/bin/${pname} || \
      cp ${pname}-v${version}-linux-arm64 $out/bin/${pname}
    
    chmod +x $out/bin/${pname}

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${pname}";
    changelog = "https://github.com/${owner}/${pname}";
    description = "RRC Notify";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
