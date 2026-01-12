{ config, ... }:
let
  inherit (config.home) username;
  inherit (config.age) secrets;
in
{
  home.file = {
    "profile.sh" = {
      target = ".profile.sh";
      text = ''
        source ${secrets."users/${username}/profile.agents.sh".path}
        source ${secrets."users/${username}/profile.secrets.sh".path}
      '';
    };
  };
}
