{ pkgs-unstable, ... }:
{
  environment = {
    systemPackages = with pkgs-unstable; [ go ];
    variables = {
      GOPROXY = "https://goproxy.cn,direct";
      GOPRIVATE = "codeup.aliyun.com";
    };
  };
}
