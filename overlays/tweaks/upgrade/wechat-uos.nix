{ lib, ... }:
final: prev:
let
  inherit (lib) optionalAttrs;
  inherit (builtins) hasAttr;
  inherit (lib) versionOlder;
  inherit (final.stdenv.hostPlatform) system;

  version = "4.1.1.4";

  srcs = {
    x86_64-linux = final.fetchurl {
      url = "https://pro-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.wechat/com.tencent.wechat_4.1.1.4_amd64.deb";
      hash = "sha256-kizJow0voh21LSq6HIuSsI/oijDRT98c8Fu1gg+N/tc=";
    };
    aarch64-linux = final.fetchurl {
      url = "https://pro-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.wechat/com.tencent.wechat_4.1.1.4_arm64.deb";
      hash = "sha256-UKo7s1WyX6vJaobXZ8r7tuu6jFNtvi4+BWGSkPmTeBs=";
    };
    loongarch64-linux = final.fetchurl {
      url = "https://pro-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.wechat/com.tencent.wechat_4.1.1.4_loongarch64.deb";
      hash = "sha256-kG1BwPD4yu+ZGi8me/l5ePUbw9SxX4jJ3Zy11MCMiSs=";
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
  wechat-uos = mkOverridden prev.wechat-uos;

  unstable = prev.unstable // {
    wechat-uos = mkOverridden prev.unstable.wechat-uos;
  };
}
