{ pkgs, config, ... }:
{
  users.mutableUsers = false;
  users.users.tsln = {
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
    extraGroups = [
      "wheel"
    ];

    isNormalUser = true;
    hashedPasswordFile = config.age.secrets."users/tsln/passwd".path;
  };
}
