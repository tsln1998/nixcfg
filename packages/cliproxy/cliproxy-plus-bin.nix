{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
}:
let
  owner = "router-for-me";
  repo = "CLIProxyAPIPlus";
  pname = "cliproxy-plus-bin";
  version = "6.8.18-1";

  srcs = {
    x86_64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/CLIProxyAPIPlus_${version}_linux_amd64.tar.gz";
      hash = "sha256-3nPxgSHpJBn/eWVlnCN4vL6ZkhLbCHSb2p1gUPRZpBg=";
    };
    aarch64-linux = fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/v${version}/CLIProxyAPIPlus_${version}_linux_arm64.tar.gz";
      hash = "sha256-e/Ec1MWwClWFeu1MdPlPg0IDTR6WUMH1mh9eiCGm4tw=";
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
    install -m755 cli-proxy-api-plus $out/bin/${pname}
    install -m644 config.example.yaml $out/

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/v${version}";
    description = "CLIProxyAPI Plus is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";
    maintainers = [ ];
    mainProgram = pname;
    license = licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
