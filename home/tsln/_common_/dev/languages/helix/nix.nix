{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "nixfmt";
          args = [
            "--filename"
            "%{buffer_name}"
          ];
        };
        language-servers = [ "nixd" ];
      }
    ];
  };
}
