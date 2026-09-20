_: final: prev: {
  mcporter = prev.mcporter.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      substituteInPlace "$out/lib/node_modules/mcporter/dist/daemon/process-retirement.js" \
        --replace-fail "exec('/bin/ps'," "exec('ps',"
    '';
  });
}
