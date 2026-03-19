{
  autoPatchelfHook,
  lib,
  libcap,
  openssl,
  stdenv,
  stdenvNoCC,
  fetchurl,
  zlib,
}:
let
  owner = "openai";
  repo = "codex";
  pname = "codex";
  version = "0.115.0";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-x86_64-unknown-linux-gnu.tar.gz";
      hash = "sha256-HEkvSvzabAf7FMwFxjaEviUKRApb/wuiiOSIhi2DnSE=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-aarch64-unknown-linux-gnu.tar.gz";
      hash = "sha256-nWIcwgR3+IWR1zuxly3PivL5/sZ4AC9MKh6ogFMSW9k=";
    };
  };

  src =
    srcs.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    libcap
    openssl
    stdenv.cc.cc.lib
    zlib
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 codex-* $out/bin/codex

    runHook postInstall
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
