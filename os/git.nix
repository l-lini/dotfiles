{ ... }:

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
    };
  };
}
