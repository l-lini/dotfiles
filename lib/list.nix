with builtins;
{
  inherit concatStringSep;
  last = xs: elemAt xs (length xs - 1);
  tryElemAt = i: xs: if length xs > i then elemAt xs i else null;
  orElse = x: nullable: if nullable == null then x else nullable;
}
