{ pkgs, ... }:
{
  programs.go.enable = true;

  home.packages = with pkgs.unstable; [
    gopls
    delve
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
  ];
}
