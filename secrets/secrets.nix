let
  keys = import ./keys.nix;
  inherit (keys) hosts users;
in
{
  # Mini PC
  "hosts/minipc/ssh_host_ed25519_key.age".publicKeys = hosts.minipc ++ users.tsln;
  "hosts/minipc/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/minipc/samba/password.age".publicKeys = hosts.minipc ++ users.tsln;

  # Oracle Cloud Singapore 1
  "hosts/oracle-sin-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-sin-1/cpa/config.yaml.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/cpa/config.env.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/cch/config.env.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/xray/config.json.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/nginx/config.conf.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/restic/repository.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/restic/password.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/restic/env.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;

  # Oracle Cloud USA Phoenix 1
  "hosts/oracle-phx-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-phx-1/xray/config.json.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/nginx/config.conf.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;

  # User - tsln
  "users/tsln/id_ed25519.age".publicKeys = users.tsln;
  "users/tsln/id_ed25519.pub.age".publicKeys = keys.all;
  "users/tsln/kube/config.age".publicKeys = users.tsln;
  "users/tsln/codex/config.toml.age".publicKeys = users.tsln;
  "users/tsln/nix/nix.conf.age".publicKeys = users.tsln;
}
