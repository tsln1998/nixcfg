{ inputs, ... }: final: prev: {
  repos = (prev.repos or { }) // {
    keyring = final.callPackage "${inputs.keyring}/nix/packages/keyring-rs-bin.nix" { };
  };
}
