with builtins;
rec {
  inherit concatStringSep;
  pathsInDir = dir: map (name: /${dir}/${name}) (namesInDir dir);
  dirToAttr =
    dir: nameF: valueF:
    listToAttrs (path: {
      name = nameF path;
      value = valueF path;
    });
  readDirFiles = dirToAttr baseNameOf readFile;
  endsWith =
    end: s:
    let
      s' = toString s;
      le = stringLength end;
      ls = stringLength s';
    in
    substring (ls - le) le s' == end;
  # !BEWARE OF FUNKY REGEX SHIT!
  splitString = sep: s: filter isString (split (toString sep) (toString s));
}
