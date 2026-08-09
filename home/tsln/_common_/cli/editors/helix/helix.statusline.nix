{
  programs.helix.settings.editor.statusline = {
    left = [
      "mode"
      "spinner"
      "file-name"
      "read-only-indicator"
      "file-modification-indicator"
    ];
    center = [ "version-control" ];
    right = [
      "diagnostics"
      "selections"
      "register"
      "position"
      "position-percentage"
      "file-encoding"
      "file-line-ending"
      "file-type"
    ];
    separator = "│";
    mode = {
      normal = "NORMAL";
      insert = "INSERT";
      select = "SELECT";
    };
    diagnostics = [
      "warning"
      "error"
    ];
    workspace-diagnostics = [
      "warning"
      "error"
    ];
  };
}
