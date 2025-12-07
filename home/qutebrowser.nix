{ ... }:

{
        programs.qutebrowser = {
                enable = true;
                settings = {
                        colors = {
                                hints = {
                                        bg = "#000000";
                                        fg = "#ffffff";
                                };
                                tabs.bar.bg = "#000000";
                        };
                        fonts.default_size = "20px";
                        fonts.default_family = "Mona Sans";
                };
        };
}
