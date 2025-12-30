{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:
let
  owner = "tsln1998";
  pname = "rrc";
  rev = "f0cb838308e5ba7750f7c5c07a3ae3aa570377d7";
  hash = "sha256-vq1zXT+c6qiOu9WqFsDiqd/ndTHKo9rGAYbQbI+VN+w=";
  cargoHash = "sha256-kJ62OEw6rvdtsqy962hrauuAE1Rc3gu5T+rhWvH0aJc=";
in
rustPlatform.buildRustPackage {
  inherit pname cargoHash;
  version = builtins.substring 0 6 rev;

  src = fetchFromGitHub {
    inherit owner;
    inherit rev hash;
    repo = pname;
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}";
    description = "RRC Notify";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
  };
}
