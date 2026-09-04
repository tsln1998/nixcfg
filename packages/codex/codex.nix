{
  lib,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  installShellCompletions ? stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform,
}:
let
  owner = "openai";
  repo = "codex";
  pname = "codex";
  version = "0.153.2";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-x86_64-unknown-linux-musl.tar.gz";
      hash = "sha256-4Q+gzueOnwvTlYgPA/1P0ifZA8p69km7wI0WSRAekiU=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-aarch64-unknown-linux-musl.tar.gz";
      hash = "sha256-o7+vS2L8sX4KAzjf4FAkE93OCrGzkChnk5BTnEXSxuM=";
    };
    x86_64-darwin = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-x86_64-apple-darwin.tar.gz";
      hash = "sha256-bjh25/Tt/y497lReHTsjNIZnkajfzn4leJv2eZNVpOo=";
    };
    aarch64-darwin = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-KH4t0Km7+1hYGwqRUDmUWLTwlOpCyvAoYPHoy1ogKgs=";
    };
  };

  src =
    srcs.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    installShellFiles
  ];

  sourceRoot = ".";
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -R bin codex-package.json codex-path codex-resources $out/

    runHook postInstall
  '';

  postInstall = lib.optionalString installShellCompletions ''
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
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
