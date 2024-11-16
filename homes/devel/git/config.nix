{ ... }:
{
  programs.git.extraConfig = {
    core = {
      autocrlf = "input";
      eol = "lf";
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
    };
  };

}
