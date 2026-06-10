{ tools, ... }:
{
  imports = tools.scan ./.;

  home.sessionVariables = {
    CC = "gcc";
    CXX = "g++";
  };
}
