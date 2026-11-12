{
  lib,
  stdenvNoCC,
  fetchurl,
}:
let
  inherit (builtins.fromJSON (builtins.readFile ./update.json)) version platforms;
  inherit (stdenvNoCC.hostPlatform) system;
  asset = platforms.${system} or (throw "Unsupported system: ${system}");
  archiveName = baseNameOf asset.url;
in
stdenvNoCC.mkDerivation {
  pname = "keyring-rs-bin";
  inherit version;

  src = fetchurl asset;

  sourceRoot = lib.removeSuffix ".tar.gz" archiveName;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 keyring "$out/bin/keyring"
    install -Dm644 README.md "$out/share/doc/keyring-rs/README.md"
    install -Dm644 LICENSE "$out/share/licenses/keyring-rs/LICENSE"

    runHook postInstall
  '';

  doInstallCheck = stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform;
  installCheckPhase = ''
    runHook preInstallCheck
    "$out/bin/keyring" --help >/dev/null
    runHook postInstallCheck
  '';

  meta = with lib; {
    description = "Bitwarden SSH agent with platform key stores";
    homepage = "https://github.com/tsln1998/keyring-rs";
    license = licenses.mit;
    mainProgram = "keyring";
    platforms = builtins.attrNames platforms;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
