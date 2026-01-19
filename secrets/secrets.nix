let
  keys = import ./keys.nix;
  inherit (keys) hosts users;
in
{
  # ThinkBook 16+ G6 IMH (WSL)
  "hosts/tb16g6imh-wsl/ssh_host_ed25519_key.age".publicKeys = hosts.tb16g6imh-wsl ++ users.tsln;
  "hosts/tb16g6imh-wsl/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;

  # ThinkBook 16+ G6 IMH
  "hosts/tb16g6imh/ssh_host_ed25519_key.age".publicKeys = hosts.tb16g6imh ++ users.tsln;
  "hosts/tb16g6imh/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;

  # Oracle Cloud Singapore 1
  "hosts/oracle-sin-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-sin-1/hysteria.yaml.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/xray.json.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/shadowsocks.json.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/cliproxy.yaml.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/rclone.toml.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;
  "hosts/oracle-sin-1/caddyfile.age".publicKeys = hosts.oracle-sin-1 ++ users.tsln;

  # Oracle Cloud India 1
  "hosts/oracle-bom-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;
  "hosts/oracle-bom-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-bom-1/hysteria.yaml.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;
  "hosts/oracle-bom-1/xray.json.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;
  "hosts/oracle-bom-1/shadowsocks.json.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;
  "hosts/oracle-bom-1/caddyfile.age".publicKeys = hosts.oracle-bom-1 ++ users.tsln;

  # Oracle Cloud USA Phoenix 1
  "hosts/oracle-phx-1/ssh_host_ed25519_key.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/ssh_host_ed25519_key.pub.age".publicKeys = keys.all;
  "hosts/oracle-phx-1/hysteria.yaml.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/xray.json.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/shadowsocks.json.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;
  "hosts/oracle-phx-1/caddyfile.age".publicKeys = hosts.oracle-phx-1 ++ users.tsln;

  # User - tsln
  "users/tsln/id_ed25519.age".publicKeys = users.tsln;
  "users/tsln/id_ed25519.pub.age".publicKeys = keys.all;
  "users/tsln/profile.agents.sh.age".publicKeys = users.tsln;
  "users/tsln/profile.secrets.sh.age".publicKeys = users.tsln;
  "users/tsln/factory-droid.json.age".publicKeys = users.tsln;
  "users/tsln/opencode.json.age".publicKeys = users.tsln;
  "users/tsln/oh-my-opencode.json.age".publicKeys = users.tsln;
}
