{ lib, ... }:
{
  # lsp easy
  # tree-sitter easy
  # auto indent detection
  # harpoon or fuzzy finder or file explorer or similar (pick one)
  # undo-tree
  # system clipboard
  enable = true;
  colorschemes.catppuccin.enable = true;
  plugins = {
    lualine.enable = true;
    plugins.undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };
    nix.enable = true;
    treesitter.enable = true;
  };
  vim.opt.shiftwidth = 4;
  # Auto format
}
