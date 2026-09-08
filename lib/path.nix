with builtins;
with import ./list.nix;
rec {
  extension = baseName: (head (orElse [ "" ] (tryElemAt 1 (split ".*([.].*)" baseName))));
  pathToName =
    path:
    let
      baseName = baseNameOf path;
      ext = extension baseName;
    in
    substring 0 (stringLength baseName - stringLength ext) baseName;
  pathsInDir =
    dir: if pathExists dir then map (name: /${dir}/${name}) (attrNames (readDir dir)) else [ ];
  dirPathsToAttr =
    dir: nameF: valueF:
    listToAttrs (
      map (path: {
        name = nameF path;
        value = valueF path (nameF path);
      }) (pathsInDir dir)
    );
}
