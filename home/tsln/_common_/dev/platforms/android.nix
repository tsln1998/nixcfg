{ pkgs, ... }:
{
  home.packages = [
    pkgs.android-sdk
    pkgs.android-tools
  ];

  home.sessionVariables = {
    ANDROID_HOME = "${pkgs.android-sdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${pkgs.android-sdk}/libexec/android-sdk";
  };

  nixpkgs.config = {
    android_sdk = {
      accept_license = true;
    };
  };
}
