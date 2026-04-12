{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  dolt,
  icu74,
  autoPatchelfHook,
  makeWrapper,
  installShellFiles,
  installShellCompletions ? stdenv.buildPlatform.canExecute stdenv.hostPlatform,
}:
let
  owner = "gastownhall";
  repo = "beads";
  pname = "beads";
  version = "1.0.0";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/beads_${version}_linux_amd64.tar.gz";
      hash = "sha256-cFfbHpJCj89cCNXcawfq1X5YiyYsuni5omiT1VvSn9s=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/beads_${version}_linux_arm64.tar.gz";
      hash = "sha256-m7MEEwQeUNrJRaD4qmQBHks0Xr/Qo/m1/M1kbG3KYac=";
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
    installShellFiles
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    icu74
  ];

  sourceRoot = ".";

  dontAutoPatchelf = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 bd $out/bin/bd

    runHook postInstall
  '';

  postFixup = ''
    autoPatchelf -- "$out"
    wrapProgram $out/bin/bd --prefix PATH : ${lib.makeBinPath [ dolt ]}
  '' + lib.optionalString installShellCompletions ''
    installShellCompletion --cmd bd \
      --bash <($out/bin/bd completion bash) \
      --fish <($out/bin/bd completion fish) \
      --zsh <($out/bin/bd completion zsh)
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "Distributed issue tracker designed for AI-supervised coding workflows";
    maintainers = [ ];
    mainProgram = "bd";
    license = licenses.mit;
    platforms = attrNames srcs;
  };
}
