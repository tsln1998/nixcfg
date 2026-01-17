{ config, ... }:
let
  inherit (config.home) username homeDirectory;
in
{
  age.secrets."users/${username}/profile.agents.sh" = {
    path = "${homeDirectory}/.profile.agents.sh";
  };

  age.secrets."users/${username}/profile.secrets.sh" = {
    path = "${homeDirectory}/.profile.secrets.sh";
  };

  age.secrets."users/${username}/factory-droid.json" = {
    path = "${homeDirectory}/.factory/settings.json";
  };
}
