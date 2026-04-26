{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [ keyd ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            esc = "capslock";
            capslock = "esc";
            altgr = "layer(altgr)";
            "altgr+shift" = "layer(altgr+shift)";
          };
          altgr = {
            "[" = "å";
            "'" = "ä";
            ";" = "ö";
          };
          "altgr+shift" = {
            "[" = "Å";
            "'" = "Ä";
            ";" = "Ö";
          };
        };
      };
    };
  };
}
