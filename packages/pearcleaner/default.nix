{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
let
  sources = builtins.fromJSON (builtins.readFile ./update.json);
  inherit (stdenvNoCC.hostPlatform) system;
in
stdenvNoCC.mkDerivation {
  pname = "pearcleaner";
  inherit (sources) version;

  src = fetchurl (sources.platforms.${system} or (throw "Unsupported system: ${system}"));

  nativeBuildInputs = [ unzip ];
  sourceRoot = ".";
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications" "$out/bin"
    cp -a Pearcleaner.app "$out/Applications/"
    ln -s "$out/Applications/Pearcleaner.app/Contents/MacOS/Pearcleaner" "$out/bin/pearcleaner"

    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    test -x "$out/bin/pearcleaner"
    test -f "$out/Applications/Pearcleaner.app/Contents/Info.plist"
    runHook postInstallCheck
  '';

  passthru.updateScript = ./update.py;

  meta = {
    description = "macOS app cleaner and uninstaller";
    homepage = "https://github.com/alienator88/Pearcleaner";
    license = with lib.licenses; [
      asl20
      commons-clause
    ];
    platforms = builtins.attrNames sources.platforms;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "pearcleaner";
  };
}
