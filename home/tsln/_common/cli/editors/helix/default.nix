{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings.editor = {
      line-number = "relative";
      cursorline = true;
      scrolloff = 8;
      bufferline = "multiple";
      popup-border = "all";
      true-color = true;
      completion-trigger-len = 1;
      completion-timeout = 5;
      end-of-line-diagnostics = "hint";

      lsp = {
        display-messages = true;
        display-progress-messages = true;
        auto-signature-help = true;
        display-inlay-hints = true;
        display-signature-help-docs = true;
        snippets = true;
      };

      cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };

      file-picker = {
        hidden = false;
        follow-symlinks = true;
        ignore = true;
        git-ignore = true;
        git-global = true;
        git-exclude = true;
      };

      indent-guides = {
        render = true;
        character = "╎";
        skip-levels = 1;
      };

      soft-wrap = {
        enable = true;
        max-wrap = 25;
        max-indent-retain = 0;
        wrap-indicator = "↪ ";
      };

      inline-diagnostics = {
        cursor-line = "warning";
        other-lines = "error";
      };

      statusline = {
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
    };
  };
}
