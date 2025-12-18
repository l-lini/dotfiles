{ ... }:
# Same lock and login screen. Simple. Matching color scheme and font and size etc ... (simple)
# Switch language keybind with notif for language
# Battery-, Network-, Time-, Keybinds-, Sound-, notif on keybind
# Nice background
# File explorer (Vim keybinds)
# Screenshot
# Master slave layout (keep same master, add slaves)
# Blurred background on not focused. Opaque if focused
# toggle mirror screen
# Low battery notification
# Fix qutebrowser crashing every first startup (check logs maybe. google if it is a common issue)

{
        # deps
        imports = [
                ./kitty.nix
                ./qutebrowser.nix 
                ./wofi.nix
        ];

        services.swaync.enable = true;

        wayland.windowManager.sway = let
                modifier = "Mod4";
                terminal = "kitty";
                browser = "qutebrowser";
                menu = "wofi --show run";
                left = "h";
                down = "j";
                up = "k";
                right = "l";
        in {
                enable = true;
                config = rec {
                        inherit modifier terminal menu left down up right;
                        startup = [
                                # { command = terminal; always = true; }
                                # { command = browser; always = true; }
                        ];
                        bars = [];
                        colors = let
                                red = "#ff0000";
                                idk = {
                                        background = red;
                                        border  = red;
                                        childBorder = red;
                                        indicator = red;
                                        text = "#000000";
                                };
                                unfocused = {
                                        background = "#000000";
                                        border = "#997811";
                                        childBorder = "#775528";
                                        indicator = "f49e2e";
                                        text = "#ffffff";
                                };
                                focused = {
                                        background = "#000000";
                                        border = "#4c7899";
                                        childBorder = "#285577";
                                        indicator = "2e9ef4";
                                        text = "#ffffff";
                                };
                        in {
                                background = "#ffffff";
                                focusedInactive = idk; # I don't fucking know
                                placeholder = idk; # when restoring layouts?
                                urgent = idk; # urgency hint active
                                unfocused = unfocused; # non-active window
                                focused = focused; # active window
                        };
                        defaultWorkspace = "workspace number 1";
                        floating.border = 2; # floating window border width
                        floating.criteria = []; # list of attributes to be floating
                        floating.modifier = modifier; # "Mod4"
                        floating.titlebar = false;
                        focus.followMouse = true; # focus windows under the mouse
                        focus.mouseWarping = false; # warp mouse to focused window
                        focus.newWindow = "focus"; # smart, urgent, focus or none
                        focus.wrapping = "workspace"; # how to wrap around edge
                        input = {
                                # see sway-input(5) for options
                        };
                        # Replace caps-lock with escape or shift or whatever
                        # Start sway automatically. Because of encryption thingie we could
                        # just omitt the password I think.
                        keybindings = {
                                "${modifier}+Return" = "exec ${terminal}";
                                "${modifier}+Space" = "exec ${menu}";
                                "${modifier}+q" = "exec ${browser}";
                                "${modifier}+Print" = "exec slurp | grim -g - - | wl-copy";
                                "${modifier}+Backspace" = "kill";
                                "${modifier}+Shift+Slash" = "exec libnotify hello"; # Show keybinds;
                                "${modifier}+f" = "fullscreen toggle";
                                "${modifier}+o" = "floating toggle";
                                "${modifier}+Ctrl+${left}" = "resize shrink width 100 px";
                                "${modifier}+Ctrl+${right}" = "resize grow width 100 px";
                                "${modifier}+Ctrl+${up}" = "resize grow height 100 px";
                                "${modifier}+Ctrl+${down}" = "resize shrink height 100 px";
                                "${modifier}+Shift+${left}" = "move left";
                                "${modifier}+Shift+${right}" = "move right";
                                "${modifier}+Shift+${up}" = "move up";
                                "${modifier}+Shift+${down}" = "move down";
                                "${modifier}+${left}" = "focus left";
                                "${modifier}+${right}" = "focus right";
                                "${modifier}+${up}" = "focus up";
                                "${modifier}+${down}" = "focus down";
                                "${modifier}+1" = "workspace number 1";
                                "${modifier}+2" = "workspace number 2";
                                "${modifier}+3" = "workspace number 3";
                                "${modifier}+4" = "workspace number 4";
                                "${modifier}+5" = "workspace number 5";
                                "${modifier}+6" = "workspace number 6";
                                "${modifier}+7" = "workspace number 7";
                                "${modifier}+8" = "workspace number 8";
                                "${modifier}+9" = "workspace number 9";
                                "${modifier}+0" = "workspace number 10";
                                "${modifier}+Shift+1" = "move to workspace number 1";
                                "${modifier}+Shift+2" = "move to workspace number 2";
                                "${modifier}+Shift+3" = "move to workspace number 3";
                                "${modifier}+Shift+4" = "move to workspace number 4";
                                "${modifier}+Shift+5" = "move to workspace number 5";
                                "${modifier}+Shift+6" = "move to workspace number 6";
                                "${modifier}+Shift+7" = "move to workspace number 7";
                                "${modifier}+Shift+8" = "move to workspace number 8";
                                "${modifier}+Shift+9" = "move to workspace number 9";
                                "${modifier}+Shift+0" = "move to workspace number 10";
                                "XF86MonBrightnessDown" = "exec brightnessctl s 25%- -e 2 -n 1";
                                "XF86MonBrightnessUp" = "exec brightnessctl s +25% -e 2";
                                "${modifier}+b" = "exec notify-send -t 2000 \"$(cat /sys/class/power_supply/BAT0/status) $(cat /sys/class/power_supply/BAT0/capacity)%\"";
                                "${modifier}+t" = "exec notify-send -t 2000 \"$(date '+%A %d %H:%M\')\"";
                                # change screen mode on button press is on nixos wiki for sway under tips and tricks.
                                # notifications (battery, time, network, language) keybinds. 
                                # brightness keys, volume keys (with notification)
                                # Keybind for notification of activity bar
                        };
                        output = { };
                        seat."*".hide_cursor = "when-typing enable";
                        window = {
                                border = 5;
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
                                        font = "Mona Sans";
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
                        # gtk = false;
                        base = true;
                };
                xwayland = true;
        };
}
