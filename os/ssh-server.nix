{
  port,
  interface,
  address,
  defaultGateway ?
    with builtins;
    let
      xs = splitVersion address;
      x = elemAt xs;
      xs' = map x (genList (x: x) 3) ++ [ "1" ];
    in
    concatStringsSep "." xs',
  nameservers ? [
    "1.1.1.1"
  ],
}:

{
  services.openssh = {
    enable = true;
    ports = [ port ];
  };

  networking = {
    inherit nameservers defaultGateway;

    firewall = {
      enable = true;
      allowedTCPPorts = [ port ];
    };

    interfaces.${interface}.ipv4.addresses = [
      {
        address = address;
        prefixLength = 24;
      }
    ];
  };
}
