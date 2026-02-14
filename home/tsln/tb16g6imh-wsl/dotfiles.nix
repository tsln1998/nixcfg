{ config, ... }:
let
  inherit (config.home) username homeDirectory;
in
{
  age.secrets."users/${username}/config/profile.d/agents.sh" = {
    path = "${homeDirectory}/.config/profile.d/agents.sh";
  };

  age.secrets."users/${username}/config/profile.d/secrets.sh" = {
    path = "${homeDirectory}/.config/profile.d/secrets.sh";
  };

  age.secrets."users/${username}/config/opencode/opencode.json" = {
    path = "${homeDirectory}/.config/opencode/opencode.json";
  };

  age.secrets."users/${username}/config/opencode/oh-my-opencode.json" = {
    path = "${homeDirectory}/.config/opencode/oh-my-opencode.json";
  };
}
