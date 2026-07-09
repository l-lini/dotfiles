{ pencils, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      # key_left = "l";
      # key_right = "r";
      # key_up = "k";
      # key_down = "j";
      width = 800;
      height = 600;
    };
  };
}
