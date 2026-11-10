let
  inherit (builtins) concatLists attrValues;

  keys = import ./agenix-keys.nix;

  users = keys.users // {
    all = concatLists (attrValues keys.users);
  };

  hosts = keys.hosts // {
    all = concatLists (attrValues keys.hosts);
  };
in
{
  # Mini PC
  "hosts/minipc/ssh_host_ed25519_key.age".publicKeys = hosts.minipc ++ users.tsln;

  # Oracle Cloud Singapore 1
  "hosts/oracle-sin-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/magpie/config.env.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/xray/config.json.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/nginx/config.conf.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/hysteria/config.yaml.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;

  # Oracle Cloud USA Phoenix 1
  "hosts/oracle-phx-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/xray/config.json.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/nginx/config.conf.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/hysteria/config.yaml.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;

  # User - tsln
  "users/tsln/id_ed25519.age".publicKeys = users.tsln;
  "users/tsln/nix/nix.conf.age".publicKeys = users.tsln;
  "users/tsln/kube/config.age".publicKeys = users.tsln;
  "users/tsln/codex/config.toml.age".publicKeys = users.tsln;
  "users/tsln/pi/agent/models.json.age".publicKeys = users.tsln;
  "users/tsln/keyring/config.toml.age".publicKeys = users.tsln;
}
