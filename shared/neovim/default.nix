{ lib, pkgs, ... }:
# TODO add plugin to get vim specific stuffs in lua
# TODO add plugin to get nixos specific stuff in nix
# TODO no autocomplete in comments
# TODO auto hide cmp when done
# TODO remove confirm keybind cmp
# TODO highlight TODO's
# stop autocomplete in comments. fuck you bitch. that's fucking dumb as hell.
# Default to tabwidth = 2
# relative line numbers
# relative line numbers in explorer
# grep thingie in folder
# disable arrow keys
# disable mouse (in all terminal instances and neovim etc...) ()
# lsp easy
# tree-sitter easy
# auto indent detection
# harpoon or fuzzy finder or file explorer or similar (pick one)
# undo-tree
# system clipboard
# Auto format
# Autosave on close
# Auto sudo on write protected
# haskell with good lsp. hlint builtin.
# Se lsp and tree-sitter errors
# Autocomplete
# TODO notes highlighted
# TODO look at kickstart nvim for inspiration

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customLuaRC = import ./combineLua.nix { inherit lib; };
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nvim-treesitter.withAllGrammars
          tokyonight-nvim
          nvim-lspconfig
          telescope-nvim
          harpoon
          undotree
          vim-fugitive
          nvim-cmp
          cmp-buffer
          cmp-path
          cmp_luasnip
          cmp-nvim-lsp
          cmp-nvim-lua
          luasnip
          friendly-snippets
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    java-language-server
    nil
    lua-language-server
    ripgrep
  ];
}
