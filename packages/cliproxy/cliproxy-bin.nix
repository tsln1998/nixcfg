{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
}:
let
  owner = "router-for-me";
  repo = "CLIProxyAPI";
  pname = "cliproxy-bin";
  version = "6.8.18";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/CLIProxyAPI_${version}_linux_amd64.tar.gz";
      hash = "sha256-zzYEMbphablHpi4yUkmlaPtz3I/TGRojgxJriryKxmQ=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/CLIProxyAPI_${version}_linux_arm64.tar.gz";
      hash = "sha256-KUj3+TWQfJ1Fma9h29rCcaznbCJY2NmnOH1fukfHnqA=";
    };
  };

  src = srcs.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation rec {
  inherit pname version src;

  nativeBuildInputs = [ autoPatchelfHook ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 cli-proxy-api $out/bin/${pname}
    install -m644 config.example.yaml $out/

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "CLIProxyAPI is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
