{
  lib,
  stdenvNoCC,
  fetchurl,
  appimageTools,
  desktop-file-utils,
}:
let
  pname = "aictionary";
  inherit (builtins.fromJSON (builtins.readFile ./update.json)) version platforms;
  inherit (stdenvNoCC.hostPlatform) system;

  src = fetchurl (platforms.${system} or (throw "Unsupported system: ${system}"));
  appimageContents = appimageTools.extractType2 { inherit pname version src; };

  meta = {
    description = "Desktop dictionary with offline lookups and audio pronunciation";
    homepage = "https://github.com/ahpxex/Aictionary";
    changelog = "https://github.com/ahpxex/Aictionary/releases/tag/v${version}";
    license = with lib.licenses; [
      mit
      cc-by-sa-40
    ];
    mainProgram = pname;
    platforms = builtins.attrNames platforms;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
in
if stdenvNoCC.hostPlatform.isDarwin then
  stdenvNoCC.mkDerivation {
    inherit
      pname
      version
      src
      meta
      ;

    sourceRoot = ".";
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/Applications" "$out/bin"
      cp -R Aictionary.app "$out/Applications/"
      ln -s "$out/Applications/Aictionary.app/Contents/MacOS/aictionary-re" "$out/bin/aictionary"

      runHook postInstall
    '';
  }
else
  appimageTools.wrapType2 {
    inherit
      pname
      version
      src
      meta
      ;

    extraPkgs = pkgs: [
      pkgs.webkitgtk_4_1
      pkgs.libayatana-appindicator
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-bad
      pkgs.gst_all_1.gst-libav
    ];

    nativeBuildInputs = [ desktop-file-utils ];

    profile = ''
      export LD_LIBRARY_PATH="/usr/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    '';
    runScript = "${appimageContents}/usr/bin/aictionary-re";

    extraInstallCommands = ''
      install -Dm644 ${appimageContents}/Aictionary.desktop "$out/share/applications/aictionary.desktop"
      cp -R ${appimageContents}/usr/share/icons "$out/share/"
      desktop-file-edit \
        --set-key=Exec --set-value="$out/bin/aictionary %U" \
        --set-key=Categories --set-value="Office;Dictionary;" \
        "$out/share/applications/aictionary.desktop"
      desktop-file-validate "$out/share/applications/aictionary.desktop"
    '';
  }
