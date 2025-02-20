{ tools, ... }:
let
  inherit (tools) relative;
in
{
  age.secrets."users/tsln/passwd" = {
    file = relative "secrets/users/tsln/passwd.age";
  };
}
