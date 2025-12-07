{ ... }:

{
        programs.wofi = {
                enable = true;
                settings = {
                        key_left = "l";
                        key_right = "r";
                        key_up = "k";
                        key_down = "j";
                        width = 800;
                        height = 600;
                };
                style = ''
                        * {
                                font-family: "Mona Sans";
                                font-size: 24;
                                color: white;
                        }

                        window {
                                background-color: #000000;
                        }
                '';
        };
}
