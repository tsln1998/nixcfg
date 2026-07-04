let
  inherit (builtins) concatLists attrValues;

  users = {
    tsln = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPnBz0T25JuOeNUqb+SVj56cKeFew7HFokCiRr1hzsn"
    ];
  };

  hosts = {
    minipc = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGAkFEAhSYaKtw30BigRgUjZtwq9iFVKAS/5m8vWBprr"
    ];
    oracle-sin-1 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbdrPFrrWj6DTbSAI7dv4wtuWSrZMZ55VS26RNysb1J"
    ];
    oracle-phx-1 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9BxLKduJubzOdDgUjleA3UmCnYrFIP7cwg1JkQ87oe"
    ];
  };
in
{
  users = users // {
    all = concatLists (attrValues users);
  };

  hosts = hosts // {
    all = concatLists (attrValues hosts);
  };

  all = concatLists (attrValues users) ++ concatLists (attrValues hosts);
}
