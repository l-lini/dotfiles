{
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customLuaRC = builtins.readFile ./init.lua;
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nvim-treesitter.withAllGrammars
          # telescope-nvim
          # harpoon
          # undotree
          # vim-fugitive
          # nvim-cmp
          # cmp-buffer
          # cmp-path
          # cmp_luasnip
          # cmp-nvim-lsp
          # cmp-nvim-lua
          # luasnip
          # friendly-snippets
          # surround-nvim
        ];
      };
    };
  };

  # Set the default editor to neovim
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    # java-language-server
    nil
    lua-language-server
    # ripgrep
    # asm-lsp
    # bash-language-server
    # ccls
    # rust-analyzer
  ];
}
