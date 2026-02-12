{ lib, pkgs, ... }:
# TODO line-wrap toggle keybind
# TODO use global pencils colors instead of colorscheme
# TODO get lsp for asm and java working
# TODO haskell lsp
# TODO add plugin to get vim specific stuffs in lua
# TODO add plugin to get nixos specific stuff in nix
# TODO no autocomplete in comments
# TODO auto hide cmp when done
# TODO remove confirm keybind cmp
# TODO highlight TODO's
# TODO look at kickstart nvim for inspiration
# TODO add primeagen's keybinds
# stop autocomplete in comments. fuck you bitch. that's fucking dumb as hell.
# relative line numbers in explorer
# disable arrow keys
# disable mouse
# lsp easy
# auto indent detection
# TODO fix harpoon and other keybinds not working
# harpoon or fuzzy finder or file explorer or similar (pick one)
# system clipboard
# Auto format
# Auto sudo on write protected

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
    asm-lsp
    bash-language-server
    ccls
  ];
}
