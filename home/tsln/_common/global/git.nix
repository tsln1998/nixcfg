{ lib, ... }:
{
  # Install git (pull configuration from remote repositories)
  programs.git = {
    enable = lib.mkDefault true;
  };
}
