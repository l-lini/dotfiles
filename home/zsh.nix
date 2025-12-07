{ ... }:
# zsh
# zoxide
# command history thingy with fuzzy finding.
# Alias for nixupdate = git add . && git commit -m "$1" && git push && sudo nixos-rebuild switch
# Alias for nixtest = git add . && sudo nixos-rebuild test
{
        programs.zsh = {
                enable = true;
                enableCompletion = true;
                autosuggestion.enable = true;
                syntaxHighlighting.enable = true;
                shellAliases = {
                        update = "f() { git -C /etc/nixos add . && git -C /etc/nixos commit -m $1 && git push && sudo nixos-rebuild switch };f";
                        tstcfg = "git -C /etc/nixos add . && sudo nixos-rebuild test";
                };
                history.size = 10000;
        };
}
