{
  pkgs,
  tools,
  ...
}:
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

  nixpkgs = {
    flake = {
      setFlakeRegistry = false;
      setNixPath = false;
    };
  };

  # Mask tmpfiles.d rules for directories that are btrfs subvolumes here
  environment.etc = {
    "tmpfiles.d/home.conf".source = pkgs.emptyFile;
    "tmpfiles.d/portables.conf".source = pkgs.emptyFile;
    "tmpfiles.d/systemd-nspawn.conf".source = pkgs.emptyFile;
  };
}
