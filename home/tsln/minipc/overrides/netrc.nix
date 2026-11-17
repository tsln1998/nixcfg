{
  config,
  tools,
  ...
}:
let
  inherit (config.home) username homeDirectory;in{

  age.secrets."users/${username}/netrc" = {
    file = tools.relative "secrets/users/${username}/netrc.age";
    mode = "600";
    path = "${homeDirectory}/.netrc";
  };
}