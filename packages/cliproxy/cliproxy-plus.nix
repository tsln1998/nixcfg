{
  lib,
  buildGoModule,
  fetchFromGitHub,
  curl,
  xdg-utils,
  desktop-file-utils,
}:
let
  owner = "router-for-me";
  repo = "CLIProxyAPIPlus";
  pname = "cliproxy-plus";
  version = "6.6.67-0";
  rev = "refs/tags/v${version}";
  hash = "sha256-xB9pDTF6QvusBT5KriXt2/9ghVm8k8OR4bfi2ec5NtY=";
  vendorHash = "sha256-eMzl/rMQi4kOyJsohEiUB4yMdmrkLr8XJ4k71ZFZ2p8=";
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
    ./patches/002-fix-shebang-path.patch
    ./patches/003-add-kiro-github-login.patch
  ];

  buildInputs = [
    curl
    xdg-utils
    desktop-file-utils
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
    ldflags+=" -X main.BuildDate=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  '';

  postInstall = ''
    mv $out/bin/server $out/bin/${pname}
    cp $src/config.example.yaml $out/
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "CLIProxyAPI Plus is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
  };
}
