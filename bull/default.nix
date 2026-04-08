{ hostName, ... }:

{
  imports = [
    ../shared
    ./hardware.nix # TODO
    ./disko-install.nix # TODO
  ];

  services.openssh = {
    enable = true;
    ports = [ 42069 ];
  };

  networking.firewall.enable = false;

  networking.hostName = hostName;

  networking.interfaces.enp5s0.ipv4.addresses = [
    {
      address = "10.20.51.26";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "10.20.51.1";
  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];
}
