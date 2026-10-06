_: _: prev: {
  mcporter =
    if prev.mcporter.version == "0.13.13" then
      prev.mcporter.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          substituteInPlace "$out/lib/node_modules/mcporter/dist/daemon/process-retirement.js" \
            --replace-fail "exec('/bin/ps'," "exec('ps',"
        '';
      })
    else
      prev.mcporter;
}
