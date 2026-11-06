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
      var REGEX_ID = /^(.+\/)?([^\/]+)$/;
      var REGEX_DOT = / · [\s\S]*$/;
      var REGEX_VIA = /\s*via magpie$/;
      var chunks = [];

      var resharp = {
        items: function(items, identifier) {
          var entries = [];
          var seen = Object.create(null);

          for (var index = 0; index < items.length; index++) {
            var model = items[index];

            if (model == null || typeof model[identifier] !== "string") {
              continue;
            }

            var match = REGEX_ID.exec(model[identifier]);
            if (match == null) {
              continue;
            }

            var group = match[1] || "";
            if (group !== "group/") {
              continue;
            }

            var name = match[2] || "";
            if (seen[name] === true) {
              continue;
            }

            seen[name] = true;

            entries.push(this.clear(model));
          }

          return entries;
        },

        clear: function(item) {
          var entry = Object.assign({}, item);
  
          if (typeof entry.display_name === "string") {
            entry.display_name = this.strip(entry.display_name)
          }

          if (typeof entry.description === "string") {
            entry.description = this.strip(entry.description)
          }

          if (typeof entry.magpie_label === "string") {
            delete entry.magpie_label;
          }

          if (typeof entry.owned_by === "string") {
            delete entry.owned_by;
          }

          return entry;
        },

        strip: function(text) {
          text = text.replace(REGEX_DOT, "");
          text = text.replace(REGEX_VIA, "");
          return text
        },

        models: function(payload) {
          if (payload == null || !Array.isArray(payload.data)) {
            return payload;
          }

          return { object: "list", data: this.items(payload.data, "id") };
        },

        codex: function(payload) {
          if (payload == null || !Array.isArray(payload.models)) {
            return payload;
          }

          return { models: this.items(payload.models, "slug") };
        }
      };

      function clear(r) {
        delete r.headersOut["Content-Length"];
      }

      function filter(r, data, flags) {
        if (r.status < 200 || r.status >= 300) {
          r.sendBuffer(data, flags);
          return;
        }

        chunks.push(Buffer.from(data));

        if (flags.last) {
          var buffer = Buffer.concat(chunks);
          try {
            switch (r.uri) {
              case "/v1/models":
                buffer = JSON.stringify(resharp.models(JSON.parse(buffer.toString())))
                break;
              case "/v1/codex/models":
                buffer = JSON.stringify(resharp.codex(JSON.parse(buffer.toString())))
                break;
            }
          } catch (e) {
            r.error("models rewrite failed: " + e);
          } finally {
            r.sendBuffer(buffer, { last: true, flush: true });
          }
        }
      }

      export default { clear, filter };
    '';
  };
}
