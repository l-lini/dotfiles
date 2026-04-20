with builtins;
rec {
  inherit concatStringSep;
  last = xs: elemAt xs (length xs - 1);
  tryElemAt = i: xs: if length xs > i then elemAt xs i else null;
  orElse = x: nullable: if nullable == null then x else nullable;
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
  dirToAttr =
    dir: nameF: valueF:
    listToAttrs (
      map (path: {
        name = nameF path;
        value = valueF path (nameF path);
      }) (pathsInDir dir)
    );
  hexToUpper = replaceStrings [ "a" "b" "c" "d" "e" "f" ] [ "A" "B" "C" "D" "E" "F" ];
  pencil = {
    void = "000000";
    ground = "002233";
    text = "ffffff";
    bad = "ff0000";
    good = "00ff00";
    keyword = "eeaa66";
    variable = "ff0077";
    function = "00bbdd";
    literal = "99cc66";
    comment = "334477";
    console_colors = with pencil; [
      void
      bad
      good
      keyword
      variable
      function
      literal
      text
      ground
      bad
      good
      comment
      comment
      comment
      comment
      comment
      comment
    ];
  };
}
