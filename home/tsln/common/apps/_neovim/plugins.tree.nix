{ ... }:
{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      key = "<M-1>";
      action = "<cmd>NvimTreeToggle<CR>";
    }
  ];
}
