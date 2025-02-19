{
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "Tsln";
    userEmail = lib.mkDefault "tsln1998@gmail.com";
  };
}
