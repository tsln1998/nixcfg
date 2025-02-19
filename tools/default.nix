{ ... }@inputs:
{
  scan = import ./scan.nix inputs;
  module = import ./module.nix inputs;
  relative = import ./relative.nix inputs;
}
