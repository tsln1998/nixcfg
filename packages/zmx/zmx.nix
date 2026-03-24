{
  fetchurl,
  lib,
  stdenvNoCC,
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

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 zmx $out/bin/zmx

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/blob/main/README.md";
    description = "Session persistence for terminal processes";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = pname;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
