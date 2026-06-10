{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/i18n"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
