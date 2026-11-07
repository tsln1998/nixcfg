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
  pname = "feishu";
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

    application=$(find . -type d -name Lark.app -print -quit)
    test -n "$application"

    mkdir -p "$out/Applications" "$out/bin"
    cp -a "$application" "$out/Applications/Feishu.app"
    ln -s "$out/Applications/Feishu.app/Contents/MacOS/Feishu" "$out/bin/feishu"

    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    test -x "$out/bin/feishu"
    test -f "$out/Applications/Feishu.app/Contents/Info.plist"
    runHook postInstallCheck
  '';

  passthru.updateScript = ./update.py;

  meta = {
    description = "All-in-one collaboration suite";
    homepage = "https://www.feishu.cn/";
    license = lib.licenses.unfree;
    platforms = builtins.attrNames sources.platforms;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "feishu";
  };
}
