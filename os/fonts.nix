{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    comic-relief
    comic-mono
    biz-ud-gothic
  ];
}
