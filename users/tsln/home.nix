{
  inputs,
  outputs,
  tools,
  pkgs,
  config,
  ...
}:
{
  imports = [ (tools.relative "<home-manager>") ];

  home-manager.users.tsln = import ../../home/tsln/${config.networking.hostName};
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };
}
