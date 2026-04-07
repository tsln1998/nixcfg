{ pkgs, lib, ... }:
{
  home.packages = [
    (pkgs.feishu.overrideAttrs (prev: {
      postFixup = (prev.postFixup or "") + ''
        ${lib.getExe pkgs.gnused} -i \
          's/^Categories=.*/Categories=Network;/' \
          "$out/share/applications/bytedance-feishu.desktop"
      '';
    }))
  ];
}
