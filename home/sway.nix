{ ... }:

{
        wayland.windowManager.sway = let
                modifier = "Mod4";
                terminal = "kitty";
                menu = "wofi";
        in {
                enable = true;
                config = rec {
                        inherit modifier terminal menu;
                        startup = [
                                { command = "kitty"; always = true; }
                                { command = "qutebrowser"; }
                        ];
                        bars = [];
                        colors = {
                                focusedInactive = null; # I don't fucking know
                                placeholder = null; # when restoring layouts?
                                unfocused = null; # non-active window
                                focused = null; # active window
                                urgent = null; # urgency hint active
                        };
                        defaultWorkspace = "workspace number 1";
                        up = "k";
                        down = "j";
                        left = "h";
                        right = "l";
                        floating.border = 2; # floating window border width
                        floating.criteria = null; # list of attributes to be floating
                        floating.modifier = null; # "Mod4"
                        floating.titlebar = false;
                        focus.followMouse = true; # focus windows under the mouse
                        focus.mouseWarping = false; # warp mouse to focused window
                        focus.newWindow = "focus"; # smart, urgent, focus or none
                        focus.wrapping = "worksapce"; # how to wrap around edge
                        fonts = {
                                names = [ "" ];
                                style = "Bold Semi-Condensed";
                                size = 14.0;
                        };
                        # gaps = null;
                        input = {
                                # see sway-input(5) for options
                        };
                        keybinds = let
                                mod = modifier;
                        in {
                                "${mod}+Return" = "exec ${terminal}";
                                "${mod}+k" = "kill";
                                "${mod}+/" = null; # Show keybinds;
                        };
                        modes = null; # Fuck this shit
                        output = {
                                "*" = null;
                        };
                        seat = {
                                "*" = {
                                        hide_cursor = "when-typing enable";
                                };
                        };
                        window = {
                                border = 2;
                                commands = [
                                        {
                                                command = "pkill steam";
                                                criteria = {
                                                        class = "Steam";
                                                };
                                        } # lol
                                ];
                                hideEdgeBorders = "both"; # Hide borders to the edge of the screen
                                titlebar = false;
                        };
                        workspaceAutoBackAndForth = true; # Banger for a chaotic person as myself :)
                        workspaceLayout = "default";
                        workspaceOutputAssign = [
                                {
                                        output = "eDP";
                                        workspace = "workspace number 2";
                                }
                        ];
                };
                extraConfig = ""; # add to config
                extraConfigEarly = ""; # add to config before the rest
                extraOptions = [
                        # "--unsupported-gpu"
                        # etc ...
                ];
                # extraSessionCommands = ''
                #         export SDL_VIDEODRIVER=wayland
                # '';
                swaynag = {
                        enable = true;
                        settings = {
                                "<config>" = {
                                        edge = "bottom";
                                        font = "Dina 12";
                                };

                                green = {
                                        edge = "top";
                                        background = "00AA00";
                                        text = "FFFFFF";
                                        button-background = "00CC00";
                                        message-padding = 10;
                                };
                        };
                };
                systemd = {
                        enable = true;
                        extraCommands = [
                                # "systemctl --user reset-failed"
                        ];
                        variables = [
                                "DISPLAY"
                                "WAYLAND_DISPLAY"
                                "SWAYSOCK"
                                "XDG_CURRENT_DESKTOP"
                                "XDG_SESSION_TYPE"
                                "NIXOS_OZONE_WL"
                                "XCURSOR_THEME"
                                "XCURSOR_SIZE"
                        ];
                        xdgAutostart = false;
                };
                wrapperFeatures = {
                        gtk = false;
                        base = true;
                };
                xwayland = true;
        };
}
