{
  inputs,
  tools,
  ...
}:
{
  imports = (tools.scan ./.) ++ [
    inputs.nix-darwin-app.homeManagerModules.default
  ];

  targets.darwin.copyApps.enable = false;
  targets.darwin.linkApps.enable = true;
}
