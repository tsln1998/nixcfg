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
  version = "0.153.4";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-x86_64-unknown-linux-musl.tar.gz";
      hash = "sha256-qCIYfhokIMYcWSZyG/vYeHAe2VVHybsNTeRJiha6GCE=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-aarch64-unknown-linux-musl.tar.gz";
      hash = "sha256-/DlcsEOhCTqw2zT0Sroxmb+qnOZAzZvn/ViPRLDaZKQ=";
    };
    x86_64-darwin = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-x86_64-apple-darwin.tar.gz";
      hash = "sha256-PuY41xVchW7zHz9Khcshld4ZOZYtOSTJNbJPBRRWSj0=";
    };
    aarch64-darwin = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-NUONofv3ptt92zvOyERI+mAVuhiEYUcql9nR2n2cQ1M=";
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
