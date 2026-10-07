{
  pkgs,
  ...
}:
{
  services.comin = {
    enable = true;
    package = pkgs.comin;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/tsln1998/nixcfg.git";
        branches = {
          main = {
            name = "main";
          };
        };
      }
    ];
  };
}
