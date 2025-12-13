{
  lib,
  buildGoModule,
  fetchFromGitHub,
  owner ? "router-for-me",
  repo ? "CLIProxyAPI",
  pname ? "cliproxy",
  version ? "6.6.8",
  hash ? "sha256-omet0BLXRdbzYamJx6AmpPRy7ifgVPYLU/oMTTS1AGY=",
  vendorHash ? "sha256-kF5VyRyrIza+QrTcuNQZznTrBZ3Pf1QTOJi9Twby6j4=",
}:
let
  rev = "refs/tags/v${version}";
in
buildGoModule rec {
  inherit pname version vendorHash;

  src = fetchFromGitHub {
    inherit owner repo;
    inherit rev hash;
  };

  subPackages = [
    "cmd/server"
  ];

  ldflags = [
    "-s"
    "-w"
  ];

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
