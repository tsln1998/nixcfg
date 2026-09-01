{
  lib,
  stdenv,
  fetchurl,
  alsa-lib,
  asar,
  at-spi2-atk,
  autoPatchelfHook,
  cairo,
  cups,
  dbus,
  expat,
  glib,
  gtk3,
  libdrm,
  libgbm,
  libGL,
  libx11,
  libxcb,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxkbcommon,
  libxrandr,
  libxshmfence,
  makeDesktopItem,
  makeWrapper,
  ncurses,
  nspr,
  nss,
  pango,
  systemd,
  vulkan-loader,
}:
let
  pname = "pen";
  version = "1.2.7";

  libraries = lib.makeLibraryPath [
    libGL
    libdrm
    libgbm
    libxshmfence
    vulkan-loader
  ];

  shortcut = makeDesktopItem {
    name = pname;
    desktopName = "Pen";
    comment = "Design on canvas and land in code";
    icon = pname;
    exec = "@out@/libexec/pen/pen";
    categories = [
      "Graphics"
      "Development"
    ];
  };
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    name = "Pen-linux-x64.tar.gz";
    url = "https://web.archive.org/web/20260901015925if_/https://storage.googleapis.com/pencil-desktop-releases/Pen-linux-x64.tar.gz?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=508864965535-compute%40developer.gserviceaccount.com%2F20260901%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20260901T015923Z&X-Goog-Expires=300&X-Goog-SignedHeaders=host&X-Goog-Signature=49fc247830c12af0ccb2761e8bd3b2b5a04607f4e369aaf9a99f5052d93c7bbe4f2b260ba10bb61a017383ad1f89c8e8232143a86ddfb51f0a760a1242f263231e9916f1e4fa089a3a22ac3b8ab09bb195a93d423a520028ebbda5a9b9c4f31e228ea38a2afd0a856d39ed0d3c2efece840eecf1eb8540591f79eff51d1dae385339cce6f389e04c498b1741585c89cf8759af8da1d8f6f91ea314cf888dcd142ada9f9a640b963c5fbbc1bd0468ca2bc3e066629f5309c0691f3941fc93cd8f6dea8a28712b81faf67644be47f1e98a2bfe096a5d8beae3479a4dffdb7e3c528b52b61f89dc5ac85af6e5cb61569a959e33627b9be25f5168ea0097387479e8";
    hash = "sha256-OVx3w3dnR1pJ7Q9r2temKZJukPytT1OVz9g3Ik9MYd4=";
  };

  sourceRoot = "Pen-${version}-linux-x64";

  nativeBuildInputs = [
    asar
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libgbm
    libGL
    libx11
    libxcb
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxkbcommon
    libxrandr
    libxshmfence
    ncurses
    nspr
    nss
    pango
    systemd
    vulkan-loader
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/opt/pen" "$out/libexec/pen" "$out/share/applications"
    cp -a . "$out/opt/pen/"

    makeWrapper "$out/opt/pen/pen" "$out/libexec/pen/pen" \
      --prefix LD_LIBRARY_PATH : ${libraries} \
      --add-flags "--force-device-scale-factor=1" \
      --add-flags "\''${WAYLAND_DISPLAY:+--enable-features=WaylandWindowDecorations --enable-wayland-ime=true}"

    asar extract-file "$out/opt/pen/resources/app.asar" out/assets/512x512.png
    install -Dm644 512x512.png "$out/share/icons/hicolor/512x512/apps/pen.png"

    substitute "${shortcut}/share/applications/pen.desktop" \
      "$out/share/applications/pen.desktop" \
      --replace-fail "@out@" "$out"

    runHook postInstall
  '';

  meta = {
    description = "AI design canvas that turns designs into code";
    homepage = "https://www.pen.dev/";
    downloadPage = "https://www.pen.dev/downloads";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
