let
  inherit (builtins) concatLists attrValues;

  users = {
    tsln = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDq45URPrEHk5bm8yEsv5horJ/ctJpm3hff7k0GFqcI6"
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA6uGIRCXOS6B5vgdlV3KkOuxGor/5CMgcjbLsQ5mPedqvmAcJACSrt4RE5EjiMxBFEAo6pUVG0HRNszSZls4v8AcWT/TQzrYQVZgOxCuw6cXbFmVx6fokAYip2vPoi8PD645Ze8ihQAtXXSOyzaNkJHRUX97ovDKcONYG3VgPTzjjS578DyyeR57a3YutLQq+Ib5JoAZSRZAPl2kxetcFwyd6CM/utMLq0X3e/eLyEKqUtdhz2Qq98TyE8B68kg77G3WHtIvlC4lfOb5c0LG17FH1q9sCITOw80Lg2c/c4OdBFUv29hD5OEpTxPaXrwuVoGZVXHaCHGk4HM1ofCmAJjgmh+5S3InfS4s87cUZQW/QP0xwnLf6cRmkC++B2FGjmRUdDrr9VPqsBCNLUtdR39RQcwG6y+0Tvo2/6LHhobQX5AvUEoWqVUj+82h9//M/OltffZQ0YryjJQDWK/PpziZS7Zm42RyTFGX3I5boW9/DdoF/Owiw5sWrJP2CVWUcrIKqBxwwRjne2Z4aI3CU2SJiKugDW9nT86QBfst6qnZzcE8nBOHrbgcbLg0hd6fcHmJb98G4B9I2uLfJdJ96C+Bv2ppM9kP3WKfO/Fb2ZWk94ri+X+UFGOuhiNKTR9fbVE3Z9fNCffDXDkpztOeIEhwDEFG6Ojo8b8WJ4PoTgR0="
    ];
  };

  hosts = {
    tb16g6imh-wsl = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTluQQEUjOLtK+EmsP1TwosvnUVVnc7uE3WuNIUqqX4"
    ];
    tb16g6imh-vm = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGAkFEAhSYaKtw30BigRgUjZtwq9iFVKAS/5m8vWBprr"
    ];
    thinkpad-x280 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2PncLvH0OvD/gU2Yfa3WFzTMQK61gtsahHb8wYMGjt"
    ];
    oracle-sin-1 = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbdrPFrrWj6DTbSAI7dv4wtuWSrZMZ55VS26RNysb1J"
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

  all = concatLists (attrValues users // hosts);
}
