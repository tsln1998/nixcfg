{ ... }:
{
  services.cliproxy = {
    enable = true;
    secret = "unsecret";
    management = true;
    statistics = true;
    image = "eceasy/cli-proxy-api-plus";
    tag = "v6.6.8-1";
    cmd = "CLIProxyAPIPlus";
  };
}
