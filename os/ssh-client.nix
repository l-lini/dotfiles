{ ... }:

{
  services.openssh = {
    enable = true;
  };
  programs.ssh.extraConfig = "
      Host bull
        Hostname alteborn.se
        Port 42069
        User lini
    ";
}
