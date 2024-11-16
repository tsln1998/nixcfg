{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    lib.optionals config.programs.go.enable [
      protoc-gen-go-grpc
      protoc-gen-go
    ];
}
