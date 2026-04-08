with builtins;
rec {
  inherit concatStringSep;
  pathsInDir = dir: map (name: /${dir}/${name}) (attrNames (readDir dir));
  dirToAttr =
    dir: nameF: valueF:
    listToAttrs (
      map (path: {
        name = nameF path;
        value = valueF path;
      }) (pathsInDir dir)
    );
  readDirFiles = dir: dirToAttr dir baseNameOf readFile;
  endsWith =
    end: s:
    let
      s' = toString s;
      le = stringLength end;
      ls = stringLength s';
    in
    substring (ls - le) le s' == end;
  removeEnd =
    end: s:
    let
      s' = toString s;
      le = stringLength end;
      ls = stringLength s';
    in
    if endsWith end s' then substring 0 (ls - le) s' else s';
  # !BEWARE OF FUNKY REGEX SHIT!
  splitString = sep: s: filter isString (split (toString sep) (toString s));
}
