{
  config,
  lib,
  pkgs,
  ...
}:

let
  myScripts = pkgs.stdenv.mkDerivation {
    name = "my-scripts";
    src = ./scripts; # folder with your .sh files

    installPhase = ''
      mkdir -p $out/bin
      for f in *.sh; do
        install -m755 "$f" "$out/bin/$\{f%.sh}"
      done
    '';
  };
in
{
  options.myScripts.enable = lib.mkEnableOption "Install my custom scripts";

  config = lib.mkIf config.myScripts.enable {
    environment.systemPackages = [ myScripts ];
  };
}
