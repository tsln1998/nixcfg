{
  autoPatchelfHook,
  lib,
  makeWrapper,
  stdenv,
  stdenvNoCC,
  fetchurl,
  bubblewrap,
  zlib,
  libcap,
  openssl,
}:
let
  owner = "openai";
  repo = "codex";
  pname = "codex";
  version = "0.118.0-alpha.3";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-x86_64-unknown-linux-gnu.tar.gz";
      hash = "sha256-5+JTwgKZ/i6ldPdkA0+lw2eYqyqpUXYamD3ByWwAR6M=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-aarch64-unknown-linux-gnu.tar.gz";
      hash = "sha256-8F7saWB6d2cPmYCwd8QqVmkPfWDlv9atFit4qfbYJ60=";
    };
  };

  src =
    srcs.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    openssl
    zlib
  ] ++ lib.optionals stdenv.hostPlatform.isLinux [
    libcap
    bubblewrap
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 codex-* $out/bin/codex

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/codex \
      --prefix PATH : ${lib.makeBinPath [ bubblewrap ]}
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/rust-v${version}";
    description = "Lightweight coding agent that runs in your terminal";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.asl20;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
