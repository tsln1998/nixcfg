{
  inputs,
  tools,
  ...
}:
{
  imports = (tools.scan ./.) ++ [
    inputs.nix-darwin-app.homeManagerModules.default
  ];
}
