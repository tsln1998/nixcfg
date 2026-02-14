{ ... }:
{
  home.persistence."/persist" = {
    directories = [
      { directory = ".ssh"; mode = "0700"; }
      { directory = ".bun"; mode = "0755"; }
      { directory = ".cache"; mode = "0755"; }
      { directory = ".cargo"; mode = "0755"; }
      { directory = ".claude"; mode = "0755"; }
      { directory = ".config"; mode = "0755"; }
      { directory = ".factory"; mode = "0755"; }
      { directory = ".go"; mode = "0755"; }
      { directory = ".gradle"; mode = "0755"; }
      { directory = ".local"; mode = "0755"; }
      { directory = ".npm"; mode = "0755"; }
      { directory = ".vscode"; mode = "0755"; }
      { directory = "Codebases"; mode = "0755"; }
      { directory = "Desktop"; mode = "0755"; }
      { directory = "Documents"; mode = "0755"; }
      { directory = "Downloads"; mode = "0755"; }
      { directory = "Music"; mode = "0755"; }
      { directory = "Pictures"; mode = "0755"; }
      { directory = "Public"; mode = "0755"; }
      { directory = "Templates"; mode = "0755"; }
      { directory = "Videos"; mode = "0755"; }
    ];
    files = [
      ".claude.json"
    ];
  };
}
