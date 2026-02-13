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
    tb16g6imh = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGAkFEAhSYaKtw30BigRgUjZtwq9iFVKAS/5m8vWBprr"
    ];
    oracle-sin-1 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbdrPFrrWj6DTbSAI7dv4wtuWSrZMZ55VS26RNysb1J"
    ];
    oracle-sin-2 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfVjyuhAbv15X+PkbMA8J6ero+ff9NPiiYr/gWG7t8O"
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
