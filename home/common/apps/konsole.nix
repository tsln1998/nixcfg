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
          name = "Fira Code";
          size = 11;
        };
      };
    };
  };
}
