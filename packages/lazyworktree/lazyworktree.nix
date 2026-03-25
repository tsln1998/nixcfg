{
  fetchurl,
  installShellFiles,
  lib,
  stdenvNoCC,
}:
let
  owner = "chmouel";
  repo = "lazyworktree";
  pname = "lazyworktree";
  version = "1.44.0";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/lazyworktree_Linux_x86_64.tar.gz";
      hash = "sha256-ujk+bCCN51RAyYjGEyayD2xlm8C2vB29m3QzDs2u1qM=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/lazyworktree_Linux_arm64.tar.gz";
      hash = "sha256-1F2pwiRAKc1QNrMCReasp/S/5CoNAt+hEurafXeRLPQ=";
    };
  };

  src =
    srcs.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ installShellFiles ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 lazyworktree $out/bin/lazyworktree

    installShellCompletion --cmd lazyworktree \
      completions/lazyworktree.bash \
      completions/lazyworktree.fish \
      completions/lazyworktree.zsh

    installManPage lazyworktree.1

    mkdir -p $out/share/lazyworktree/shell
    install -m644 shell/functions.bash $out/share/lazyworktree/shell/
    install -m644 shell/functions.fish $out/share/lazyworktree/shell/
    install -m644 shell/functions.zsh $out/share/lazyworktree/shell/

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "Terminal UI for managing Git worktrees";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = pname;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
