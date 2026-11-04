{
  lib,
  stdenv,
  fetchzip,
  cmake,
  ninja,
  python3,
  python3Packages,
  uni-algo,
}:
let
  sources = builtins.fromJSON (builtins.readFile ./update.json);
in
stdenv.mkDerivation {
  pname = "fcitx5-phono-core";
  inherit (sources) version;

  src = fetchzip {
    inherit (sources) url hash;
    extension = "tar.gz";
  };

  nativeBuildInputs = [
    cmake
    ninja
    (python3.withPackages (ps: [
      ps.torch
      ps.pyyaml
    ]))
  ];
  buildInputs = [ uni-algo ];

  postUnpack = ''
    mkdir -p "$sourceRoot/third_party/executorch"
    cp -R ${python3Packages.executorch.src}/. "$sourceRoot/third_party/executorch"
    chmod -R u+w "$sourceRoot/third_party/executorch"
  '';

  postPatch = ''
    pushd third_party/executorch
    ${python3Packages.executorch.postPatch}
    popd
  '';

  preConfigure = ''
    export EXECUTORCH="$PWD/third_party/executorch"
    export PYTHONPATH="$PWD/third_party''${PYTHONPATH:+:$PYTHONPATH}"
  '';

  cmakeFlags = [
    (lib.cmakeBool "BUILD_TESTING" true)
    (lib.cmakeBool "CMAKE_POSITION_INDEPENDENT_CODE" true)
    (lib.cmakeBool "PHONO_DTYPE_SELECTIVE_BUILD" false)
  ];
  ninjaFlags = [
    "phono_core_shared"
    "phono_core_tests"
    "phono_capi_tests"
    "phono_ime_editor_tests"
  ];
  doCheck = true;
  checkPhase = ''
    runHook preCheck
    ctest -L unit --output-on-failure
    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall
    cmake --install . --component sdk
    for component in "$EXECUTORCH" "$EXECUTORCH"/third-party/* \
      "$EXECUTORCH"/backends/xnnpack/third-party/* "$EXECUTORCH"/kernels/optimized/third-party/*; do
      for name in LICENSE LICENSE.MIT LICENSE.txt COPYING COPYING.txt; do
        if [ -f "$component/$name" ]; then
          install -Dm644 "$component/$name" "$out/share/licenses/phono-core/third_party/executorch/''${component#"$EXECUTORCH"}/$name"
        fi
      done
    done
    runHook postInstall
  '';

  meta = {
    description = "Phono on-device Pinyin inference runtime and C ABI SDK";
    homepage = "https://github.com/phono-project/phono-core";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
  };
}
