{ ... }@inputs:
{
  scan = import ./scan.nix inputs;
  merge = import ./merge.nix inputs;
  module = import ./module.nix inputs;
  relative = import ./relative.nix inputs;
}
