{ tools, ... }:
{
  imports = tools.scan ./.;

  # Wayland supported
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  # XDG User Dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "Desktop";
    documents = "Documents";
    download = "Downloads";
    music = "Music";
    pictures = "Pictures";
    projects = "Codebases";
    templates = "Templates";
    videos = "Videos";
    publicShare = "Shared";
  };
}
