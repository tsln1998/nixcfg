{ ... }@inputs:
{
  scan = import ./scan.nix inputs;
  merge = import ./merge.nix inputs;
  relative = import ./relative.nix inputs;
}
