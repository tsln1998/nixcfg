{
  inputs,
  tools,
  ...
}:
{
  imports = (tools.scan ./.) ++ [
    inputs.plasma-manager.homeModules.plasma-manager
  ];
}
