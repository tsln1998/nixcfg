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
  version = "1.86.6";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/dolt-linux-amd64.tar.gz";
      hash = "sha256-H3i9w57fTU5zGlMTGxfUVfoNHi6HLA9fjaqkTQd1Oos=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/dolt-linux-arm64.tar.gz";
      hash = "sha256-HKoK7cViymPPwk7kuRKH5b50Rqrt3ClPGZ91FeXP3B8=";
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
