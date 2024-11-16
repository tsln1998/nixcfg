{
  config,
  lib,
  mylib,
  pkgs,
  ...
}:
let
  username = config.wsl.defaultUser;
  nickname = "Tsln";
  email = "tsln1998@users.noreply.github.com";
in
{
  users.users.${username} = {
    uid = 1000;
    shell = pkgs.bash;
    extraGroups = [ "wheel" ];

    home = "/home/${username}";
    createHome = true;

    isNormalUser = true;

    openssh.authorizedKeys.keyFiles = map mylib.relativeToRoot [
      "rsc/id_ed25519.pub"
      "rsc/id_rsa.pub"
    ];
  };

  home-manager.users.${username} = {
    home.stateVersion = "24.05";

    imports = map mylib.relativeToRoot [ "homes/devel" ];

    programs.git = {
      userName = nickname;
      userEmail = email;
    };
  };
}
