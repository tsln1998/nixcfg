{
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "Tsln";
    userEmail = lib.mkDefault "tsln1998@gmail.com";
    extraConfig = {
      core = {
        autocrlf = "input";
        eol = "lf";
      };
      color = {
        ui = "auto";
      };
      push = {
        autoSetupRemote = true;
      };
      url = {
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
