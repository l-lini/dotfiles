{ port }:
{ ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    serverProperties = {
      server-port = port;
      difficulty = 3; # Hard
    };
    jvmOpts = "-Xms4G -Xmx4G";
  };
}
