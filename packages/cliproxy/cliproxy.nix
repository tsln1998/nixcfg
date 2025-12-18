{
  lib,
  buildGoModule,
  fetchFromGitHub,
  owner ? "router-for-me",
  repo ? "CLIProxyAPI",
  pname ? "cliproxy",
  version ? "6.6.26",
  hash ? "sha256-G5Yf7aJ58gF/bfvxj1dLn3UsXfammMZ49JV1K59+JUo=",
  vendorHash ? "sha256-EjpnlOMQkIJpuB+RSW2NPQgrb1bpfOdrvF4Crs+qiKE=",
}:
let
  rev = "refs/tags/v${version}";
in
buildGoModule rec {
  inherit pname version vendorHash;

  src = fetchFromGitHub {
    inherit owner repo;
    inherit rev hash;

    leaveDotGit = true;

    postFetch = ''
      git rev-parse HEAD > $out/.git-commit
      find $out -type d -name .git -exec rm -rf {} +
    '';
  };

  subPackages = [
    "cmd/server"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  preBuild = ''
    ldflags+=" -X main.Commit=$(cat $out/.git-commit || echo unknown)"
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
