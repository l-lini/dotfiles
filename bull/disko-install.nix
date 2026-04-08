{ inputs, ... }:

{
  imports = [ inputs.disko.nixosModules.disko ];
}
// import ./disko.nix
