{pkgs,...}: {
  programs.obsidian = {
    enable = true;
    cli = {
      enable = true;
    };
    package = pkgs.obsidian;
    vaults = {
      "Default" = {
        enable = true;
        target = "Codebases/obsidian";
      };
    };
  };
}