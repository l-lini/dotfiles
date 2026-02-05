{ ... }:
# zoxide
# command history thingy with fuzzy finding.
# Alias for nixupdate = git add . && git commit -m "$1" && git push && sudo nixos-rebuild switch
# Alias for nixtest = git add . && sudo nixos-rebuild test
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    shellInit = "#hello";
    histSize = 10000;
  };
}
