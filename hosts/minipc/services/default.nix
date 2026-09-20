{ tools, ... }:
{
  imports = tools.scan ./.;

  # Bound shutdown delays from stuck desktop applications or container scopes.
  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';
}
