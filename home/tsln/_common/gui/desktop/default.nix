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

    desktop = "desktop";
    documents = "documents";
    download = "downloads";
    music = "music";
    pictures = "pictures";
    projects = "codebases";
    templates = "templates";
    videos = "videos";
    publicShare = "shared";
  };
}
