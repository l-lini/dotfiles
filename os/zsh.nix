{ ... }:
{
  # shut the fuck up bitch ass fucker
  system.userActivationScripts.zshrc = "touch .zshrc";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    shellInit = ''
      PS1="%S%n@%M %2~%s"$'\n'
      nix-env --delete-generations +3
    '';
    histSize = 10000;
  };
}
