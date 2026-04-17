{ config, lib, ... }:
let
  inherit (config.networking) hostName;
  inherit (config.age) secrets;

  keyFiles = [
    "ssh_host_ed25519_key"
    "ssh_host_ed25519_key.pub"
    "ssh_host_rsa_key"
    "ssh_host_rsa_key.pub"
  ];
in
{
  environment.etc = builtins.listToAttrs (
    map (keyFile: {
      name = "ssh/keys/${keyFile}";
      value = {
        source = (builtins.getAttr "hosts/${hostName}/${keyFile}" secrets).path;
        mode = if lib.strings.hasSuffix ".pub" keyFile then "0644" else "0600";
        user = "root";
        group = "root";
      };
    }) (lib.filter (keyFile: lib.hasAttr "hosts/${hostName}/${keyFile}" secrets) keyFiles)
  );
}
