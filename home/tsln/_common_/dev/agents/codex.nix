{
  config,
  tools,
  pkgs,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;
  inherit (pkgs.lib) versionAtLeast;

  pkg = pkgs.repos.agents.codex;
  pkg' = pkgs.repos.local.codex;

  latest = if versionAtLeast pkg.version pkg'.version then pkg else pkg';
in
{
  home.packages = [
    latest
  ];

  home.file = {
    ".codex/auth.json" = {
      text = builtins.toJSON { };
    };
  };

  age.secrets."users/${username}/codex/config.toml" = {
    file = relative "secrets/users/${username}/codex/config.toml.age";
    path = "${homeDirectory}/.codex/config.toml";
    mode = "600";
  };
}
