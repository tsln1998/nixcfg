{ ... }:
{
  programs.konsole = {
    enable = true;
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
