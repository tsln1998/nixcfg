{
  # Bound shutdown delays from stuck desktop applications or container scopes.
  systemd.user.settings.Manager = {
    DefaultTimeoutStopSec = 60;
  };
}
