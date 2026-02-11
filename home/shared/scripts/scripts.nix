{ lib, ... }:

let
  files = lib.filesystem.listFilesRecursive ./.;
  bashFiles = builtins.filter (lib.hasSuffix ".sh") files;
  simpleName = path: lib.removeSuffix ".sh" (builtins.baseNameOf path);
  keyPair = path: {
    name = simpleName path;
    value = builtins.readFile path;
  };
in
builtins.listToAttrs (map keyPair bashFiles)
