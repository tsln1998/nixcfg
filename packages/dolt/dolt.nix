{
  lib,
  stdenvNoCC,
  fetchurl,
  git,
  makeWrapper,
}:
let
  owner = "dolthub";
  repo = "dolt";
  pname = "dolt";
  version = "1.86.1";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/dolt-linux-amd64.tar.gz";
      hash = "sha256-N7S9c7TET9F3kRWzWrPgRqMy7ZnlY89WKILrT9uL3oY=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/dolt-linux-arm64.tar.gz";
      hash = "sha256-XcRsnbPLLoo7UVTvly5QJnFSDv3Nzc4N9kS2e6sn2Vg=";
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
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 dolt-*/bin/dolt $out/bin/dolt

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/dolt --prefix PATH : ${lib.makeBinPath [ git ]}
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "Relational database with version control and CLI a-la Git";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.asl20;
    platforms = attrNames srcs;
  };
}
