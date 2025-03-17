{ tools, ... }:
{
  imports = [ (tools.module "<comin>") ];
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/tsln1998/nixcfg.git";
        branches.main.name = "main";
      }
    ];
  };
}
