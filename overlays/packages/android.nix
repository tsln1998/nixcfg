_: _: prev: {
  android-sdk = (prev.androidenv.composeAndroidPackages {
    abiVersions = [
      "x86_64"
      "arm64-v8a"
      "armeabi-v7a"
    ];
    platformVersions = [ "37" ];
    buildToolsVersions = [ "37.0.0" ];
  }).androidsdk;
}
