{ ... }:
{
  services.cliproxy = {
    enable = true;
    secret = "unsecret";
    management = true;
    statistics = true;
  };
}
