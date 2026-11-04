{
  lib,
  stdenv,
  fetchzip,
  cmake,
  ninja,
  boost,
  gettext,
  pkg-config,
  python3,
  fcitx5,
  fcitx5-phono-core,
  libime,
  nlohmann_json,
  kdePackages,
}:
let
  sources = builtins.fromJSON (builtins.readFile ./update.json);
  core = fcitx5-phono-core;
  phono = stdenv.mkDerivation {
    pname = "fcitx5-phono-addons";
    inherit (sources) version;

    src = fetchzip {
      inherit (sources) url hash;
      extension = "tar.gz";
    };

    nativeBuildInputs = [
      cmake
      ninja
      gettext
      pkg-config
    ];
    buildInputs = [
      boost
      fcitx5
      libime
      nlohmann_json
      core
    ];
    nativeCheckInputs = [ python3 ];

    cmakeFlags = [
      (lib.cmakeBool "BUILD_TESTING" true)
      (lib.cmakeBool "PHONO_BUNDLE_CORE" false)
      (lib.cmakeFeature "PHONO_SDK_PREFIX" "${core}")
      (lib.cmakeFeature "PHONO_PINYIN_DICT" "${libime}/share/libime/sc.dict")
      (lib.cmakeFeature "PHONO_FCITX_ADDON_DIR" "lib/fcitx5")
      (lib.cmakeFeature "PHONO_FCITX_DATA_DIR" "share/fcitx5")
    ];

    # Loader tests need the real punctuation/fullwidth addons, not /usr paths.
    postPatch = ''
      substituteInPlace CMakeLists.txt \
        --replace-fail '/usr/share/fcitx5' '${fcitx5}/share/fcitx5' \
        --replace-fail 'FCITX_ADDON_DIRS=''${CMAKE_CURRENT_BINARY_DIR}' 'FCITX_ADDON_DIRS=''${CMAKE_CURRENT_BINARY_DIR}:${kdePackages.fcitx5-chinese-addons}/lib/fcitx5:${fcitx5}/lib/fcitx5' \
        --replace-fail 'FCITX_DATA_DIRS=''${CMAKE_CURRENT_BINARY_DIR}/data:' 'FCITX_DATA_DIRS=''${CMAKE_CURRENT_BINARY_DIR}/data:${kdePackages.fcitx5-chinese-addons}/share/fcitx5:'
    '';

    doCheck = true;
    preCheck = ''
      export HOME="$TMPDIR"
    '';

    meta = {
      description = "Local neural Pinyin and Shuangpin input methods for Fcitx5";
      homepage = "https://github.com/phono-project/phono-fcitx5-addon";
      license = lib.licenses.asl20;
      platforms = [ "x86_64-linux" ];
    };
  };
in
phono
