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
    package = lib.mkDefault pkgs.lix;

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
    "unrar"
    "wechat"
    "feishu"
    "obsidian"
    "lens-desktop"
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
