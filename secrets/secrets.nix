let
  keys = import ./keys.nix;
in
{
  # ThinkBook 16+ G6 IMH (WSL)
  "hosts/tb16g6imh-wsl/ssh_host_ed25519_key.age".publicKeys =
    keys.hosts.tb16g6imh-wsl ++ keys.users.tsln;
  "hosts/tb16g6imh-wsl/ssh_host_ed25519_key.pub.age".publicKeys =
    keys.hosts.tb16g6imh-wsl ++ keys.users.tsln;

  # VMware
  "hosts/vmware/ssh_host_ed25519_key.age".publicKeys = keys.hosts.vmware ++ keys.users.tsln;
  "hosts/vmware/ssh_host_ed25519_key.pub.age".publicKeys = keys.hosts.vmware ++ keys.users.tsln;

  # User 'tsln'
  "users/tsln/passwd.age".publicKeys = keys.all;
  "users/tsln/id_ed25519.age".publicKeys = keys.users.tsln;
  "users/tsln/id_ed25519.pub.age".publicKeys = keys.all;
  "users/tsln/id_rsa.age".publicKeys = keys.users.tsln;
  "users/tsln/id_rsa.pub.age".publicKeys = keys.all;
}
