{
  inputs,
  disk-path,
  compression,
  ...
}:

{
  imports = [ inputs.disko.nixosModules.disko ];
}
// (import ./disko.nix { inherit disk-path compression; })
