{
  programs.helix.settings.editor = {
    end-of-line-diagnostics = "hint";

    lsp = {
      display-messages = true;
      display-progress-messages = true;
      auto-signature-help = true;
      display-inlay-hints = true;
      display-signature-help-docs = true;
      snippets = true;
    };

    inline-diagnostics = {
      cursor-line = "warning";
      other-lines = "error";
    };
  };
}
