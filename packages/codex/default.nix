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

  hashes = builtins.fromJSON (builtins.readFile ./hashes.json);

  inherit (hashes) version platforms;
  inherit (stdenvNoCC.hostPlatform) system;
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchurl (platforms.${system} or (throw "Unsupported system: ${system}"));

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
    platforms = attrNames platforms;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
