{ ... }:
{
  programs.nixvim.plugins.lspsaga.enable = true;
  programs.nixvim.plugins.web-devicons.enable = true;
  programs.nixvim.keymapsOnEvents.LspAttach = [
    {
      mode = "n";
      key = "<C-CR>";
      action = "<cmd>Lspsaga code_action<CR>";
    }
    {
      mode = "n";
      key = "<A-CR>";
      action = "<cmd>Lspsaga code_action<CR>";
    }
  ];
}
