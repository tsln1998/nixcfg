{ tools, ... }:
{
  imports = tools.scan ./. ++ [ ../_common_ ];

  nix = {
    settings.trusted-users = [
      "root"
      "@wheel"
    ];

    gc = {
      dates = "daily";
      persistent = true;
      randomizedDelaySec = "15min";
    };
  };

  nixpkgs.config.allowUnfreePackages = [
    "qq"
    "wechat"
    "feishu"
    "obsidian"
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
