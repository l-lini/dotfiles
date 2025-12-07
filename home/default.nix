{ ... }:

{
        imports = [
                ./sway.nix
                ./neovim.nix
                ./zsh.nix
                ./git.nix
        ];

        home.stateVersion = "25.11";
}
