{ pkgs, secrets, ... }:

{
  environment.shellAliases = {
    g = "git";
    s = "git status";
    c = "git commit";
    a = "git add";
    p = "git push";
    u = "git pull";
    d = "git diff";
    l = "git log";
  };

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      push.autoSetupRemote = "true";
      user = {
        name = "l-lini";
        email = "119787571+l-lini@users.noreply.github.com";
      };
      credential.helper = "!${pkgs.writeShellScript "git-cred" ''
        				echo "username=l-lini"
        				echo "password=${secrets.github}"
        			''}";
    };
  };
}
# Git default pull/push with current branch
# Git default pull with rebase
