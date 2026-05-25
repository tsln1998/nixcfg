_: {
  home.persistence."/persist" = {
    directories = [
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".cache";
        mode = "0755";
      }
      {
        directory = ".cargo";
        mode = "0755";
      }
      {
        directory = ".codex";
        mode = "0755";
      }
      {
        directory = ".config";
        mode = "0755";
      }
      {
        directory = ".dolt";
        mode = "0755";
      }
      {
        directory = ".go";
        mode = "0755";
      }
      {
        directory = ".gradle";
        mode = "0755";
      }
      {
        directory = ".local";
        mode = "0755";
      }
      {
        directory = ".npm";
        mode = "0755";
      }
      {
        directory = ".vscode";
        mode = "0755";
      }
      {
        directory = ".vscode-server";
        mode = "0755";
      }
      {
        directory = "codebases";
        mode = "0755";
      }
    ];
    files = [
    ];
  };
}
