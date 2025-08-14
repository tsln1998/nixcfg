{ ... }@inputs:
(map (overlay: import overlay inputs) [
  ./nur.nix
  ./unstable.nix
  ./additions.nix
  ./agenix.nix
])
# [
#   (import ./nur inputs)
#   (import ./unstable inputs)
#   (import ./additions inputs)
#   (import ./agenix inputs)
# ]
