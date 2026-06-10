{
  lib,
  stdenvNoCC,
  fetchurl,
  bubblewrap,
  ripgrep,
  makeWrapper,
  installShellFiles,
  installShellCompletions ? stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform,
}:
let
  owner = "openai";
  repo = "codex";
  pname = "codex";
  version = "0.139.0";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
      hash = "sha256-Euv3DfQdyDEGGGKRKrXn6s3RErsX6M6bIJjLPZIYAIE=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-aarch64-unknown-linux-musl.tar.gz";
      hash = "sha256-K3QHZD4OdMUl2ENHye7OxLPSda8DghQqxCIWUIuwsqI=";
    };
  };

  src =
    srcs.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 codex-* $out/bin/codex

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/codex --prefix PATH : ${
      lib.makeBinPath ([ ripgrep ] ++ lib.optionals stdenvNoCC.hostPlatform.isLinux [ bubblewrap ])
    }
  ''
  + lib.optionalString installShellCompletions ''
    installShellCompletion --cmd codex \
      --bash <($out/bin/codex completion bash) \
      --fish <($out/bin/codex completion fish) \
      --zsh <($out/bin/codex completion zsh)
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/rust-v${version}";
    description = "Lightweight coding agent that runs in your terminal";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.asl20;
    platforms = attrNames srcs;
  };
}
