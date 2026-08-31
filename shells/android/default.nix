# An environment for Android tools
#
pkgs:
pkgs.mkShell {
  name = "android-devshell";
  packages = with pkgs; [
    android-tools
  ];
}
