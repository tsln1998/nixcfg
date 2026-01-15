{ ... }@inputs:
(map (overlay: import overlay inputs) [
  ./nur.nix
  ./llm.nix
  ./agenix.nix
  ./unstable.nix
  ./additions.nix
])
