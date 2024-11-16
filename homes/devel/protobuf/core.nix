{ pkgs, ... }:
{
  home.packages = with pkgs; [ protobuf ];
}
