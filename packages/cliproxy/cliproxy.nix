{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:
let
  owner = "router-for-me";
  repo = "CLIProxyAPI";
  pname = "cliproxy";
  version = "6.8.14";
  rev = "refs/tags/v${version}";
  hash = "sha256-CSvEFbvxZqvRFftiEFozDMiVlIK0GYMYKE13BZsY/1Y=";
  vendorHash = "sha256-OKZtvLH/CvjKyVWfjMhUdxbhHFJTMz8MqpJm60j71iY=";
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
    mv $out/bin/server $out/bin/${pname}
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
