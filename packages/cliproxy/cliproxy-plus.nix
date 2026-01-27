{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  curl,
  xdg-utils,
  desktop-file-utils,
}:
let
  inherit (stdenv.hostPlatform.extensions) executable;
  inherit (stdenv.hostPlatform) isLinux isWindows;
  owner = "router-for-me";
  repo = "CLIProxyAPIPlus";
  pname = "cliproxy-plus";
  version = "6.7.25-0";
  rev = "refs/tags/v${version}";
  hash = "sha256-MLX/PVcdb89ECSufQo4ikQfvqYmNmLYysQ2bEloBqPw=";
  vendorHash = "sha256-D8zc7+5E699gn6+evl4Q3JM1MVCXGh3VT+DEK7Mco+Q=";
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

  buildInputs =
    (lib.optionals (!isWindows) [
      curl
    ])
    ++ (lib.optionals isLinux [
      xdg-utils
      desktop-file-utils
    ]);

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
    description = "CLIProxyAPI Plus is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
  };
}
