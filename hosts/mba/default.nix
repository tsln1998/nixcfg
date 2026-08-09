{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common_/base"
      "hosts/_common_/i18n"
      "hosts/_common_/themes"
      "hosts/_darwin_/base"

      "users/_common_"
      "users/_darwin_"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
