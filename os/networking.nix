{ hostName, ... }:

{
  networking = {
    firewall.enable = true;
    hostName = hostName;
  };
}
