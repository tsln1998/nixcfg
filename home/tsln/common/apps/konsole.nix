{ tools, ... }:
{
  imports = [
    (tools.relative "home/common/apps/konsole.nix")
  ];

  programs.konsole = {
    defaultProfile = "Default";

    extraConfig = {
      MainWindow = {
        MenuBar = "Enabled";
      };
    };

    profiles = {
      Default = {
        font = {
          name = "Jetbrains Mono";
          size = 11;
        };
      };
    };
  };
}
