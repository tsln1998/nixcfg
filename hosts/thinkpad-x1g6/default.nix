{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/services/openssh.nix"
      #"hosts/common/desktop/sddm.nix"
      #"hosts/common/desktop/plasma.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  services.logind.lidSwitch = "ignore";
  services.logind.suspendKey = "ignore";
  services.logind.powerKey = "ignore";
  services.logind.hibernateKey = "ignore";
  services.logind.rebootKey = "ignore";

  system.stateVersion = "25.05";
}
