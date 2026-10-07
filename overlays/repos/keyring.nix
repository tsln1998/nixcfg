{ inputs, ... }: final: _: {
  keyring = final.callPackage "${inputs.keyring}/nix/packages/keyring-rs-bin.nix" { };
}
