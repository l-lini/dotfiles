# TODO make terminal prompt line more apparent
# TODO Make pwd on line before prompt
# TODO move into output and copy
# command history thingy with fuzzy finding.
# Alias for nixupdate = git add . && git commit -m "$1" && git push && sudo nixos-rebuild switch
# Alias for nixtest = git add . && sudo nixos-rebuild test
# Remove .zshrc prompt at boot
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
      PS1="%S%2~%s"$'\n'"%# "
      nix-env --delete-generations +3
    '';
    histSize = 10000;
  };
}
