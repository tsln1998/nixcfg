{ lib, mylib, pkgs, ... }:
let
  username = "tsln";
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
    initialHashedPassword = "$y$j9T$oepN5i.bp.KULuIHEvv0h0$e8mQlpoPV5O.wHdeiBGxLjlCldFsXf6Ho9T8l7Y3g06";

    openssh.authorizedKeys.keyFiles = map mylib.relativeToRoot [
      "rsc/id_ed25519.pub"
      "rsc/id_rsa.pub"
    ];
  };

  home-manager.users.${username} = {
    home.stateVersion = "24.05";

    programs.git = {
      enable = true;
      userName = nickname;
      userEmail = email;
    };

    imports = map mylib.relativeToRoot [
      "homes/editors/vscode"
    ];
  };
}
