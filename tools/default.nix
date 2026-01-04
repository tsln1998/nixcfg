{ ... }@inputs:
{
  scan = import ./scan.nix inputs;
  relative = import ./relative.nix inputs;
}
