{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
let
  owner = "DaoCloud";
  repo = "crproxy";
  version = "0.12.4";
  rev = "refs/tags/v${version}";
  hash = "sha256-jWSp0NzeXQu38fAaZ8eTqVN+uvpn6v5xgoi3N5SCQoc=";
in
buildGoModule rec {
  inherit version;

  pname = repo;

  src = fetchFromGitHub {
    inherit owner repo;
    inherit rev hash;
  };

  vendorHash = "sha256-R78GbtTWgizvMz3HE83ZYxAbZBvCTbsuKLvPBCB5sx4=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "CRProxy (Container Registry Proxy) is a generic image proxy";
    maintainers = [ ];
    license = licenses.mit;
  };
}
