{ ... }:

{
        imports = [
                ./sway.nix
                ./neovim.nix
                ./zsh.nix
                ./git.nix
                ./zoxide.nix
        ];

        home.stateVersion = "25.11";
}
