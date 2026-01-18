{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.home) username;
in
{
  age.secrets."users/${username}/id_ed25519" = {
    file = relative "secrets/users/${username}/id_ed25519.age";
    mode = "600";
  };

  age.secrets."users/${username}/id_ed25519.pub" = {
    file = relative "secrets/users/${username}/id_ed25519.pub.age";
    mode = "644";
  };

  age.secrets."users/${username}/profile.agents.sh" = {
    file = relative "secrets/users/${username}/profile.agents.sh.age";
    mode = "644";
  };

  age.secrets."users/${username}/profile.secrets.sh" = {
    file = relative "secrets/users/${username}/profile.secrets.sh.age";
    mode = "644";
  };

  age.secrets."users/${username}/factory-droid.json" = {
    file = relative "secrets/users/${username}/factory-droid.json.age";
    mode = "644";
  };
}
