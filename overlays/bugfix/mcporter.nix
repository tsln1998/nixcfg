{ lib, ... }: final: prev: {
  mcporter =
    if lib.versionAtLeast prev.mcporter.version "0.13.14" then
      prev.mcporter
    else
      prev.mcporter.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          substituteInPlace "$out/lib/node_modules/mcporter/dist/daemon/process-retirement.js" \
            --replace-fail "exec('/bin/ps'," "exec('ps',"
        '';
      });
}
