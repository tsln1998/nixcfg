{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  installShellCompletions ? stdenv.buildPlatform.canExecute stdenv.hostPlatform,
}:
let
  owner = "neurosnap";
  repo = "zmx";
  pname = "zmx";
  version = "0.5.0";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://zmx.sh/a/zmx-${version}-linux-x86_64.tar.gz";
      hash = "sha256-TMH2uFTczcq65MuRvQN5oj5vghAEivXYHgZh5ZSlDCg=";
    };
    aarch64-linux = fetchurl {
      url = "https://zmx.sh/a/zmx-${version}-linux-aarch64.tar.gz";
      hash = "sha256-youXaIO9bdahR9kUD9b2JewpEMs6chCCGksoWND8nVw=";
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

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 zmx $out/bin/zmx

    runHook postInstall
  '';

  postFixup = lib.optionalString installShellCompletions ''
    installShellCompletion --cmd zmx \
      --bash <($out/bin/zmx completions bash) \
      --fish <($out/bin/zmx completions fish) \
      --zsh <($out/bin/zmx completions zsh)
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "Session persistence for terminal processes";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
    platforms = attrNames srcs;
  };
}
