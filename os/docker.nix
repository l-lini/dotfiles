{ username, ... }:

{
  users.users.${username}.extraGroups = [ "docker" ];
  virtualisation.docker.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
    "electron-39.8.10"
  ];
}
