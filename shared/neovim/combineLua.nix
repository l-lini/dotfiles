{ lib, ... }:

let
files = lib.filesystem.listFilesRecursive ./.;
luaFiles = builtins.filter (lib.hasSuffix ".lua") files;
indentLines = lines: map (line: "    " + line) lines;
lines = string: lib.splitString "\n" string;
indentString = string: lib.concatStringsSep "\n" (indentLines (lines string));
indentFile = path: indentString (builtins.readFile path);
intoDoBlock = path: "do -- ${path}\n${indentFile path}\nend";
in lib.concatStringsSep "\n\n" (map intoDoBlock luaFiles)
