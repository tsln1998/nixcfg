{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:
let
  inherit (stdenv.hostPlatform.extensions) executable;
  owner = "router-for-me";
  repo = "CLIProxyAPI";
  pname = "cliproxy";
  version = "6.7.47";
  rev = "refs/tags/v${version}";
  hash = "sha256-mD0ZckACFF71m24sX5kRxXrfnH61Jo/7Tjai8/kc42Y=";
  vendorHash = "sha256-t0ttLIZDGuTxapGiMLJeMIsPuMlFpEpaeVaAFH/3mHU=";
in
buildGoModule rec {
  inherit
    pname
    version
    vendorHash
    ;

  src = fetchFromGitHub {
    inherit
      owner
      repo
      rev
      hash
      ;
  };

  patches = [
    ./patches/001-force-optional-config.patch
  ];

  subPackages = [
    "cmd/server"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  preBuild = ''
    export CGO_ENABLED=0

    ldflags+=" -X main.BuildDate=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  '';

  postInstall = ''
    mv $out/bin/server${executable} $out/bin/${pname}${executable}
    cp $src/config.example.yaml $out/
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "CLIProxyAPI is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
  };
}
