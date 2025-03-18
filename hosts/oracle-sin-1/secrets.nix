{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/caddyfile" = {
    file = relative "secrets/hosts/${hostName}/caddyfile.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/hysteria.yaml" = {
    file = relative "secrets/hosts/${hostName}/hysteria.yaml.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/xray.json" = {
    file = relative "secrets/hosts/${hostName}/xray.json.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/n8n.db.url" = {
    file = relative "secrets/hosts/${hostName}/n8n.db.url.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/n8n.db.passwd" = {
    file = relative "secrets/hosts/${hostName}/n8n.db.passwd.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/n8n.rclone" = {
    file = relative "secrets/hosts/${hostName}/n8n.rclone.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/n8n.env" = {
    file = relative "secrets/hosts/${hostName}/n8n.env.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/nezha.rclone" = {
    file = relative "secrets/hosts/${hostName}/nezha.rclone.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/nezha-agent.yaml" = {
    file = relative "secrets/hosts/${hostName}/nezha-agent.yaml.age";
    mode = "0644";
  };
}
