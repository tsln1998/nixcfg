# An environment for executing uupdump scripts
# > providing their required dependencies and the FHS environment
#
pkgs:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "uup-devshell";
    targetPkgs =
      _: with pkgs; [
        aria2
        cabextract
        wimlib
        chntpw
        cdrkit
      ];
  };
in
fhs.env
