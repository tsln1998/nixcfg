{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dotnet-ef
    dotnet-sdk_10
    dotnet-aspnetcore_10
  ];
}
