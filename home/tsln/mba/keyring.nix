{
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;

  SSH_AUTH_SOCK = "${homeDirectory}/Library/Application Support/dev.txchen.govault/ssh-agent.sock";
in
{
  home.sessionVariables = {
    inherit SSH_AUTH_SOCK;
  };
}
