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
  version = "0.4.2";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://zmx.sh/a/zmx-${version}-linux-x86_64.tar.gz";
      hash = "sha256-JSPSkAbo4NdoyA9APK0pROkNWMuj9oqRJ3sLgNDB8jc=";
    };
    aarch64-linux = fetchurl {
      url = "https://zmx.sh/a/zmx-${version}-linux-aarch64.tar.gz";
      hash = "sha256-Lj/CpiV0CGJmNEgOWmhMwk5ys0+BPQiwCKNZ+VDvyjs=";
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
