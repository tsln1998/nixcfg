{
  lib,
  stdenvNoCC,
  fetchurl,
  _7zz,
}:
let
  sources = builtins.fromJSON (builtins.readFile ./update.json);
  inherit (stdenvNoCC.hostPlatform) system;
in
stdenvNoCC.mkDerivation {
  pname = "flclash";
  inherit (sources) version;

  src = fetchurl (sources.platforms.${system} or (throw "Unsupported system: ${system}"));

  nativeBuildInputs = [ _7zz ];
  sourceRoot = ".";
  dontFixup = true;

  unpackPhase = ''
    runHook preUnpack
    7zz x -bsp0 -snld "$src"
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications" "$out/bin"
    cp -a FlClash/FlClash.app "$out/Applications/"
    ln -s "$out/Applications/FlClash.app/Contents/MacOS/FlClash" "$out/bin/FlClash"

    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    test -x "$out/bin/FlClash"
    test -f "$out/Applications/FlClash.app/Contents/Info.plist"
    runHook postInstallCheck
  '';

  passthru.updateScript = ./update.py;

  meta = {
    description = "Cross-platform proxy client based on ClashMeta";
    homepage = "https://github.com/chen08209/FlClash";
    license = lib.licenses.gpl3Plus;
    platforms = builtins.attrNames sources.platforms;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "FlClash";
  };
}
