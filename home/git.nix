{ ... }:

{
        programs.git = {
                enable = true;
                settings.user = {
                        name = "lini";
                        email = "no@thanks.com";
                };
        };
}
# Git default branch = main
# Git name = lini
# Git mail = idontwant@youremailsfuckof.gmail.com
# Git default pull/push with current branch
# Git default pull with rebase
