{ ... }:
{
  programs.nixvim.plugins.lsp.enable = true;
  programs.nixvim.plugins.lsp.servers.gopls.enable = true;
  programs.nixvim.keymapsOnEvents.LspAttach = [
    {
      mode = "n";
      key = "<C-M-l>";
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
    }
  ];
}
