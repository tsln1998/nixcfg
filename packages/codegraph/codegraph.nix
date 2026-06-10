{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
}:
let
  owner = "colbymchenry";
  repo = "codegraph";
  pname = "codegraph";
  version = "0.9.9";

  targets = {
    x86_64-linux = "linux-x64";
    aarch64-linux = "linux-arm64";
  };

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/codegraph-${targets.x86_64-linux}.tar.gz";
      hash = "sha256-xA7oC84tNUyHS+/l7OmWKBy0bPCDAENy02/YpyOLWfs=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/codegraph-${targets.aarch64-linux}.tar.gz";
      hash = "sha256-c8bldypGnYwcs8+OuToIULDeLoAQWwoCrA/QWdEn3pk=";
    };
  };

  system = stdenvNoCC.hostPlatform.system;
  target = targets.${system} or (throw "Unsupported system: ${system}");
  src = srcs.${system} or (throw "Unsupported system: ${system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  sourceRoot = "codegraph-${target}";

  dontAutoPatchelf = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 bin/codegraph $out/bin/codegraph
    install -m755 node $out/node
    cp -R lib $out/lib

    runHook postInstall
  '';

  postFixup = ''
    autoPatchelf -- "$out"
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "Semantic code intelligence CLI for coding agents";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
    platforms = attrNames srcs;
  };
}
