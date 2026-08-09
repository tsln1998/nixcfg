{
  inputs,
  outputs,
  tools,
  ...
}:
{
  imports = tools.scan ./.;
}
