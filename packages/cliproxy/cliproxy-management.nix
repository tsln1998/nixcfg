{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
let
  owner = "router-for-me";
  repo = "Cli-Proxy-API-Management-Center";
  pname = "cliproxy-management";
  version = "0.5.13";
  rev = "refs/tags/v${version}";
  hash = "sha256-9WIaNyTDTZJiCUZEb0pOYGNTQeJcrdDOvrjsjBvnNZM=";
  npmDepsHash = "sha256-1yzo87MOnANtzHofvP+AIIrksTRScw4lyTtA7bNoPWU=";
in
buildNpmPackage rec {
  inherit pname version npmDepsHash;

  src = fetchFromGitHub {
    inherit owner repo;
    inherit rev hash;
  };

  installPhase = ''
    mkdir -p $out
    cp dist/index.html $out/management.html
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "WebUI interface for managing CLI-Proxy-API, designed to simplify configuration modifications and runtime status monitoring";
    maintainers = [ ];
    license = licenses.mit;
  };
}
