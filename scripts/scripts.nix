{ pkgs, lib, ... }:

let
  paths = lib.filesystem.listFilesRecursive ./.;
  shPaths = builtins.filter (lib.hasSuffix ".sh") paths;
  toPair =
    path:
    let
      name = lib.removeSuffix ".sh" (builtins.baseNameOf path);
    in
    {
      inherit name;
      value = pkgs.writeShellApplication {
        inherit name;
        text = builtins.readFile path;
      };
    };
in
lib.listToAttrs (map toPair shPaths)
