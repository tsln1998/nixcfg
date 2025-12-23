{ ... }@inputs:
(map (overlay: import overlay inputs) [
  ./nur.nix
  ./unstable.nix
  ./additions.nix
  ./agenix.nix
  ./noctalia.nix
  ./llm.nix
])
