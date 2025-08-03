# An environment for executing uupdump scripts
# > providing their required dependencies and the FHS environment
#
pkgs:
let
  fhs = pkgs.buildFHSEnv {
    name = "aircrack-devshell";
    targetPkgs =
      _: with pkgs; [
        aircrack-ng
        wifite2
        wordlists
      ];
  };
in
fhs.env
