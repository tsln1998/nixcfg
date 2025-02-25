let
  keys = import ./keys.nix;
  inherit (keys) hosts users;
in
{
  # ThinkBook 16+ G6 IMH (WSL)
  "hosts/tb16g6imh-wsl/ssh_host_ed25519_key.age".publicKeys = hosts.tb16g6imh-wsl ++ users.tsln;
  "hosts/tb16g6imh-wsl/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;

  # ThinkBook 16+ G6 IMH (VMware)
  "hosts/tb16g6imh-vm/ssh_host_ed25519_key.age".publicKeys = hosts.tb16g6imh-vm ++ users.tsln;
  "hosts/tb16g6imh-vm/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;

  # ThinkPad X280
  "hosts/thinkpad-x280/ssh_host_ed25519_key.age".publicKeys = hosts.thinkpad-x280 ++ users.tsln;
  "hosts/thinkpad-x280/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/thinkpad-x280/mihomo.yaml.age".publicKeys = hosts.thinkpad-x280 ++ users.tsln;

  # Oracle Cloud Singapore
  "hosts/oracle-sin-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-sin-1/caddyfile.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/xray.json.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;

  # Oracle Cloud India 1
  "hosts/oracle-bom-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;
  "hosts/oracle-bom-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-bom-1/caddyfile.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;

  # User - tsln
  "users/tsln/passwd.age".publicKeys = keys.all;
  "users/tsln/id_ed25519.age".publicKeys = users.tsln;
  "users/tsln/id_ed25519.pub.age".publicKeys = keys.all;
  "users/tsln/id_rsa.age".publicKeys = users.tsln;
  "users/tsln/id_rsa.pub.age".publicKeys = keys.all;
}
