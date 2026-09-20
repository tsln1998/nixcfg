# TODO: 实在是没有找到 konsole 把 Toolbar 设置放到哪个文件，只能暂时先用 flags 覆盖
#
# 目前疑似的文件有:
#   ~/.local/state/konsolestaterc
#
_: final: prev: {
  kdePackages = prev.kdePackages.overrideScope (_: kdePrev: {
    konsole = final.symlinkJoin {
      inherit (kdePrev.konsole) name meta;
      paths = [ kdePrev.konsole ];
      nativeBuildInputs = [ final.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/konsole" --add-flags --hide-toolbars
      '';
    };
  });
}
