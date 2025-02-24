{
  inputs,
  outputs,
  tools,
  pkgs,
  config,
  ...
}:
let
  inherit (tools) relative;
  hostname = config.networking.hostName;
in
{
  imports = [ (relative "<home-manager>") ];

  # User configuration
  users.mutableUsers = false;
  users.users.tsln = {
    shell = pkgs.zsh;
    packages = [
      pkgs.home-manager
    ];
    extraGroups = builtins.filter (group: builtins.hasAttr group config.users.groups) [
      "wheel"
      "docker"
    ];

    isNormalUser = true;
    hashedPasswordFile = config.age.secrets."users/tsln/passwd".path;
  };

  # Home Manager configuration
  home-manager.users.tsln = relative "home/tsln/${hostname}";
  home-manager.backupFileExtension = "hm-bak";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };
}
