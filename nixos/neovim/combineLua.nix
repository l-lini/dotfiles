{ lib, ... }:

with lib;
with builtins;
let
  paths = pathsInDir ./.;
  luaPaths = filter (stringEndsWith ".lua") paths;
  indentLines = lines: map (line: "    " + line) lines;
  lines = string: splitString "\n" string;
  indentString = string: concatStringsSep "\n" (indentLines (lines string));
  indentFile = path: indentString (readFile path);
  intoDoBlock = path: "do -- ${path}\n${indentFile path}\nend";
in
concatStringsSep "\n\n" (map intoDoBlock luaPaths)
