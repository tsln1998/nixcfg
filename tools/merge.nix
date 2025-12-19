{ ... }:
let
  merge =
    lhs: rhs:
    lhs
    // rhs
    // (builtins.mapAttrs (
      name: value:
      if (builtins.hasAttr name lhs && builtins.isAttrs value && builtins.isAttrs lhs.${name}) then
        merge lhs.${name} value
      else if (builtins.hasAttr name lhs && builtins.isList value && builtins.isList lhs.${name}) then
        lhs.${name} ++ value
      else
        value
    ) rhs);
in
merge
