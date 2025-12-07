let
  inherit (builtins) concatLists attrValues;

  users = {
    tsln = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDq45URPrEHk5bm8yEsv5horJ/ctJpm3hff7k0GFqcI6"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPnBz0T25JuOeNUqb+SVj56cKeFew7HFokCiRr1hzsn"
    ];
  };

  hosts = {
    tb16g6imh-wsl = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTluQQEUjOLtK+EmsP1TwosvnUVVnc7uE3WuNIUqqX4"
    ];
    tb16g6imh-vm = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGAkFEAhSYaKtw30BigRgUjZtwq9iFVKAS/5m8vWBprr"
    ];
    oracle-sin-1 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbdrPFrrWj6DTbSAI7dv4wtuWSrZMZ55VS26RNysb1J"
    ];
    oracle-bom-1 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPE7Y+Jp2aGmJIKs7sKwmtt7x7n5oM0FdeufuhOhN2kw"
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
