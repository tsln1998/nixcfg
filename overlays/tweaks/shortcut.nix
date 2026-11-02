{ lib, ... }:
final: prev:
let
  inherit (lib) getExe;

  # sed -i silently no-ops when the pattern disappears upstream, so fail loudly
  # instead of shipping an unpatched desktop entry.
  setDesktopCategories = file: categories: ''
    ${getExe final.gnugrep} -q '^Categories=' "${file}" \
      || { echo "missing Categories= in ${file}" >&2; exit 1; }
    ${getExe final.gnused} -i 's/^Categories=.*/Categories=${categories};/' "${file}"
  '';
in
{
  feishu = prev.feishu.overrideAttrs (
    old:
    (lib.optionalAttrs prev.stdenv.isLinux {
      postFixup =
        (old.postFixup or "")
        + setDesktopCategories "$out/share/applications/bytedance-feishu.desktop" "Network";
    })
  );

  hoppscotch = prev.hoppscotch.override (
    lib.optionalAttrs prev.stdenv.isLinux {
      appimageTools = final.appimageTools // {
        wrapType2 =
          args:
          final.appimageTools.wrapType2 (
            args
            // {
              extraInstallCommands =
                (args.extraInstallCommands or "")
                + setDesktopCategories "$out/share/applications/hoppscotch.desktop" "Development";
            }
          );
      };
    }
  );
}
