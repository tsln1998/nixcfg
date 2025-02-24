{
  pkgs,
  config,
  ...
}:
{
  users.mutableUsers = false;
  users.users.tsln = {
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
    extraGroups = builtins.filter (group: builtins.hasAttr group config.users.groups) [
      "wheel"
      "docker"
    ];

    isNormalUser = true;
    hashedPasswordFile = config.age.secrets."users/tsln/passwd".path;
  };
}
