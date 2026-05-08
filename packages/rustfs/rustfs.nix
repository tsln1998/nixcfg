{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
let
  owner = "rustfs";
  repo = "rustfs";
  pname = "rustfs";
  version = "1.0.0-beta.2";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://dl.rustfs.com/artifacts/rustfs/release/rustfs-linux-x86_64-musl-v${version}.zip";
      hash = "sha256-Sfqhebt0diImvRkDRsiOPAeRMvE77QvWd3w9OMek2+w=";
    };
    aarch64-linux = fetchurl {
      url = "https://dl.rustfs.com/artifacts/rustfs/release/rustfs-linux-aarch64-musl-v${version}.zip";
      hash = "sha256-I7AsUcp7b4wP1N6nVZn0b6WVdK+9XQmH5lBsRD7TetE=";
    };
  };

  src =
    srcs.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ unzip ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    unzip -p "$src" rustfs > $out/bin/rustfs
    chmod 0755 $out/bin/rustfs

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/${version}";
    description = "S3-compatible high-performance object storage system";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.asl20;
    platforms = attrNames srcs;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
