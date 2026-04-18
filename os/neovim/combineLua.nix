{ util, ... }:

with util;
with builtins;
let
  paths = pathsInDir ./.;
  luaPaths = filter (path: extension (baseNameOf path) == ".lua") paths;
  indentLines = lines: map (line: "    " + line) lines;
  lines = string: filter isString (split "\n" string);
  indentString = string: concatStringsSep "\n" (indentLines (lines string));
  indentFile = path: indentString (readFile path);
  intoDoBlock = path: "do -- ${path}\n${indentFile path}\nend";
in
concatStringsSep "\n\n" (map intoDoBlock luaPaths)
