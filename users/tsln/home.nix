{
  inputs,
  outputs,
  tools,
  pkgs,
  config,
  ...
}:
let
  inherit (tools) relative;
  hostname = config.networking.hostName;
in
{
  imports = [ (relative "<home-manager>") ];

  home-manager.users.tsln = relative "home/tsln/${hostname}";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };
}
