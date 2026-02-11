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
    style = with pencils; ''
      * {
        font-family: "Comic Mono";
        font-size: 24;
        color: ${white};
      }

      window {
        background-color: ${black};
        border: 2px solid ${blue};
      }

      listview {
        background-color: ${black};
        border: none;
        padding: 10px;
      }

      listview row {
        background-color: ${black};
        color: ${white};
      }

      listview row:selected {
        background-color: ${blue};
        color: ${black};
      }

      listview row:focused {
        background-color: ${bright.black};
        color: ${white};
      }

      inputbar {
        background-color: ${black};
        color: ${cyan};
      }

      inputbar cursor {
        background-color: ${cyan};
      }
    '';
  };
}
