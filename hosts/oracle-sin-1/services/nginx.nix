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

      function reshape(text) {
        var payload = JSON.parse(text);
        var data = [];
        var seen = {};
        var items = payload.data || [];

        for (var i = 0; i < items.length; i++) {
          var model = items[i];

          var match = ID.exec(model.id || "");
          if (match == null) {
            continue;
          };

          var group = match[1] || "";
          if (group !== "" && group !== "group/") {
            continue;
          };

          var name  = match[2] || "";
          if (seen[name] === true) {
            continue;
          };

          seen[name] = true;
          
          data.push(Object.assign({}, model, {
            id: name
          }));
        }

        return JSON.stringify({ object: "list", data: data });
      }

      function clear(r) {
        delete r.headersOut["Content-Length"];
      }

      function filter(r, data, flags) {
        var buffer = (r.variables.magpie_buf || "") + data;
        if (!flags.last) {
          r.variables.magpie_buf = buffer;
          return;
        }

        r.variables.magpie_buf = "";
        try {
          r.sendBuffer(reshape(buffer), { last: true, flush: true });
        } catch (e) {
          r.error("models rewrite failed: " + e);
          r.sendBuffer(buffer, { last: true, flush: true });
        }
      }

      export default { clear, filter };
    '';
  };
}
