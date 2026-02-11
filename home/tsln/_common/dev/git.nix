{ lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = lib.mkDefault "Tsln";
        email = lib.mkDefault "tsln1998@gmail.com";
      };
      core = {
        autocrlf = lib.mkDefault "input";
        eol = lib.mkDefault "lf";
      };
      color = {
        ui = lib.mkDefault "auto";
      };
      push = {
        autoSetupRemote = lib.mkDefault true;
      };
      url = lib.mkDefault {
        "ssh://git@ssh.github.com:443/" = {
          insteadOf = "git@github.com:";
        };
        "ssh://git@altssh.gitlab.com:443/" = {
          insteadOf = "git@gitlab.com:";
        };
        "ssh://git@codeup.aliyun.com/" = {
          insteadOf = "https://codeup.aliyun.com/";
        };
      };
    };
  };
}
