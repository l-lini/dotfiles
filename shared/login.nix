{ ... }:

{
  services.getty = {
    autologinUser = "lini";
    autologinOnce = true;
  };

  environment.loginShellInit = "[[ \"$(tty)\" == /dev/tty1 ]] && sway";
}
