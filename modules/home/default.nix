{
  pkgs,
  lib,
  overlays,
  tools,
  ...
}:
{
  imports = tools.scan ./.;

  nix = {
    package = lib.mkDefault pkgs.lixPackageSets.lix_2_95.lix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
      randomizedDelaySec = "15min";
    };
  };

  nixpkgs.overlays = overlays;
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePackages = [
    "qq"
    "pen"
    "unrar"
    "wechat"
    "feishu"
    "obsidian"
    "lens-desktop"
  ]
  ++ [
    # Android SDK
    "cmake"
    "tools"
    "platforms"
    "build-tools"
    "cmdline-tools"
    "platform-tools"
    "android-sdk-tools"
    "android-sdk-platforms"
    "android-sdk-build-tools"
    "android-sdk-cmdline-tools"
    "android-sdk-platform-tools"
  ]
  ++ [
    # Visual Studio Code
    "vscode"
    "vscode-extension-ms-vscode-cpptools"
    "vscode-extension-ms-vscode-remote-remote-ssh"
    "vscode-extension-MS-python-vscode-pylance"
  ]
  ++ [
    # Chromium DRM
    "chromium"
    "chromium-unwrapped"
    "widevine-cdm"
  ];
}
