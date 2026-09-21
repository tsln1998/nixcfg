{
  lib,
  config,
  tools,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  name = "wb";
  secret = "hosts/${hostName}/${name}/config.json";
  state = "/var/lib/${name}/state";
  credentials = "/var/lib/${name}/credentials";
  image =
    (
      value:
      let
        chars = lib.stringToCharacters value;
        swap =
          remaining:
          if remaining == [ ] then
            [ ]
          else if builtins.length remaining == 1 then
            remaining
          else
            [
              (builtins.elemAt remaining 1)
              (builtins.elemAt remaining 0)
            ]
            ++ swap (builtins.tail (builtins.tail remaining));
      in
      lib.concatStringsSep "" (swap chars)
    )
      "hgrci./olsvireikssw/robkduyda2ip1:9cea9fba73287113e62eddffe7ca7e38184bc60";
in
{
  # Secrets
  age.secrets.${secret} = {
    file = relative "secrets/${secret}.age";
    mode = "0644";
  };

  # Service configuration
  virtualisation.oci-containers.containers.${name} = {
    inherit image;

    serviceName = name;

    volumes = [
      "${state}:/app/state"
      "${credentials}:/app/credentials"
      "${secrets.${secret}.path}:/app/config.json"
    ];

    extraOptions = [
      "--network=host"
    ];
  };

  systemd.services.${name} = {
    restartTriggers = [
      secrets.${secret}.file
    ];
  };
}
