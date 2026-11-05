{
  config,
  tools,
  pkgs,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/nginx/config.conf" = {
    file = relative "secrets/hosts/${hostName}/nginx/config.conf.age";
    mode = "0644";
  };

  services.nginx = {
    enable = true;
    package = pkgs.nginxStable;

    additionalModules = [
      pkgs.nginxModules.njs
    ];

    config = ''
      include ${secrets."hosts/${hostName}/nginx/config.conf".path};
    '';
  };

  systemd.services.nginx = {
    restartTriggers = [
      secrets."hosts/${hostName}/nginx/config.conf".file
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      443
    ];
  };

  # NJS files
  environment.etc = {
    "nginx/magpie.js".text = ''
      var ID = /^(.+\/)?([^\/]+)$/;

      function resharpModels(text) {
        var payload = JSON.parse(text);
        if (payload == null || !Array.isArray(payload.data)) {
          return text;
        }

        var data = [];
        var seen = Object.create(null);
        var items = payload.data;

        for (var i = 0; i < items.length; i++) {
          var model = items[i];

          if (model == null || typeof model.id !== "string") {
            continue;
          }

          var match = ID.exec(model.id);
          if (match == null) {
            continue;
          };

          var group = match[1] || "";
          if (group !== "" && group !== "group/") {
            continue;
          };

          var name = match[2] || "";
          if (seen[name] === true) {
            continue;
          };

          seen[name] = true;
          data.push(Object.assign({}, model, { id: name }));
        }

        return JSON.stringify({ object: "list", data: data });
      }

      function resharpCodex(text) {
        var payload = JSON.parse(text);
        if (payload == null || !Array.isArray(payload.models)) {
          return text;
        }

        var models = [];
        var seen = Object.create(null);
        var items = payload.models;

        for (var i = 0; i < items.length; i++) {
          var model = items[i];

          if (model == null || typeof model.slug !== "string") {
            continue;
          }

          var match = ID.exec(model.slug);
          if (match == null) {
            continue;
          }

          var group = match[1] || "";
          if (group !== "" && group !== "group/") {
            continue;
          }

          var name = match[2] || "";
          if (seen[name] === true) {
            continue;
          }

          seen[name] = true;
          models.push(Object.assign({}, model, { slug: name }));
        }

        return JSON.stringify({ models: models });
      }

      function clear(r) {
        delete r.headersOut["Content-Length"];
      }

      function filter(r, data, flags) {
        if (r.status < 200 || r.status >= 300) {
          r.sendBuffer(data, flags);
          return;
        }

        var buffer = Buffer.concat([
          Buffer.from(r.variables.magpie_buf || "", "base64"),
          data
        ]);
        if (!flags.last) {
          r.variables.magpie_buf = buffer.toString("base64");
          return;
        }

        r.variables.magpie_buf = "";
        try {
          var rewritten;
          switch (r.uri) {
            case "/v1/models":
              rewritten = resharpModels(buffer.toString());
              break;
            case "/v1/codex/models":
              rewritten = resharpCodex(buffer.toString());
              break;
            default:
              rewritten = buffer;
              break;
          }
          r.sendBuffer(rewritten, { last: true, flush: true });
        } catch (e) {
          r.error("models rewrite failed: " + e);
          r.sendBuffer(buffer, { last: true, flush: true });
        }
      }

      export default { clear, filter };
    '';
  };
}
