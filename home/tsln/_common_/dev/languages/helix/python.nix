{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [
      basedpyright
      ruff
    ];

    languages.language = [
      {
        name = "python";
        auto-format = true;
        formatter = {
          command = "ruff";
          args = [
            "format"
            "--stdin-filename"
            "%{buffer_name}"
            "-"
          ];
        };
        language-servers = [
          {
            name = "basedpyright";
            except-features = [ "format" ];
          }
          "ruff"
        ];
      }
    ];
  };
}
