{
  inputs,
  outputs,
  tools,
  pkgs,
  ...
}:
{
  # Global user configuration
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
  programs.bash.enable = true;

  programs.nh.enable = true;
  programs.nh.flake = "/etc/nixos";

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Home Manager configuration
  home-manager.backupFileExtension = "hm-bak";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };

  environment.defaultPackages = [
    pkgs.home-manager
  ];
}
