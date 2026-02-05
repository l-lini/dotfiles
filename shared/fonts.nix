{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    comic-mono
    biz-ud-gothic
  ];
}
