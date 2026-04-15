{ lib, ... }:
final: prev:
let
  inherit (lib) optionalAttrs;
  inherit (builtins) hasAttr;
  inherit (lib) versionOlder;
  inherit (final.stdenv.hostPlatform) system;

  version = "3.2.27";

  srcs = {
    x86_64-linux = final.fetchurl {
      url = "https://dldir1v6.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.27_260401_amd64_01.deb";
      hash = "sha256-iI5gc0VSZAzab2B+w1I/6idSD/zx45Ou+uyqSJzCC+c=";
    };
    aarch64-linux = final.fetchurl {
      url = "https://dldir1v6.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.27_260401_arm64_01.deb";
      hash = "sha256-sGLYPAdZmcxGy+3Lo7MEeEXysqP24XTWaQY/iM9bRLU=";
    };
  };

  mkOverridden =
    pkg:
    pkg.overrideAttrs (
      optionalAttrs (hasAttr system srcs && versionOlder pkg.version version) {
        inherit version;
        src = srcs.${system};
      }
    );
in
{
  qq = mkOverridden prev.qq;

  unstable = prev.unstable // {
    qq = mkOverridden prev.unstable.qq;
  };
}
