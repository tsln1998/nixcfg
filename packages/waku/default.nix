{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  fontconfig,
  git,
  libGL,
  libx11,
  libxcb,
  libxkbcommon,
  vulkan-loader,
  wayland,
  xdg-utils,
}:
let
  hashes = builtins.fromJSON (builtins.readFile ./hashes.json);

  inherit (hashes) version platforms;
  inherit (stdenv.hostPlatform) system;
in
stdenv.mkDerivation {
  pname = "waku";
  inherit version;

  src = fetchurl (platforms.${system} or (throw "Unsupported Waku platform: ${system}"));

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    libxcb
    libxkbcommon
  ];

  # GPUI and wgpu load these libraries at runtime.
  runtimeDependencies = map lib.getLib [
    fontconfig
    libGL
    libx11
    vulkan-loader
    wayland
  ];

  sourceRoot = "waku-${version}-${stdenv.hostPlatform.config}";
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -a bin share "$out/"
    # Package-manager installations must not offer in-app upgrades.
    rm "$out/share/waku/self-update-v1"

    # Keep the daemon and updater beside the real executable.
    wrapProgram "$out/bin/waku" \
      --suffix PATH : ${
        lib.makeBinPath [
          git
          xdg-utils
        ]
      }
    wrapProgram "$out/bin/waku-daemon" \
      --suffix PATH : ${
        lib.makeBinPath [
          git
          xdg-utils
        ]
      }
    substituteInPlace "$out/share/applications/sh.waku.desktop" \
      --replace-fail "Exec=waku" "Exec=$out/bin/waku"

    runHook postInstall
  '';

  meta = {
    description = "Native desktop app for local coding agents";
    homepage = "https://github.com/egoist/waku";
    changelog = "https://github.com/egoist/waku/releases/tag/v${version}";
    license = lib.licenses.gpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "waku";
    platforms = builtins.attrNames platforms;
  };
}
