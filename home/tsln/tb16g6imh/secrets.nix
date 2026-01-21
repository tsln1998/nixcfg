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

  age.secrets."users/${username}/config/profile.d/agents.sh" = {
    file = relative "secrets/users/${username}/config/profile.d/agents.sh.age";
    mode = "644";
  };

  age.secrets."users/${username}/config/profile.d/secrets.sh" = {
    file = relative "secrets/users/${username}/config/profile.d/secrets.sh.age";
    mode = "644";
  };

  age.secrets."users/${username}/config/opencode/opencode.json" = {
    file = relative "secrets/users/${username}/config/opencode/opencode.json.age";
    mode = "644";
  };

  age.secrets."users/${username}/config/opencode/oh-my-opencode.json" = {
    file = relative "secrets/users/${username}/config/opencode/oh-my-opencode.json.age";
    mode = "644";
  };

  age.secrets."users/${username}/factory/settings.json" = {
    file = relative "secrets/users/${username}/factory/settings.json.age";
    mode = "644";
  };
}
