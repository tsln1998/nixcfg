{ lib, pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      theme = lib.mkDefault "breeze";
      logo = pkgs.runCommand "transparent-1x1.png" { } ''
        echo -n "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=" | base64 -d > $out
      '';
    };

    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
