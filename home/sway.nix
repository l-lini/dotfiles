{ ... }:
# Make stuff look nice: (Comic Font for readability) (Nice Colorscheme) (Simple)
# TODO! Make Login nice
# TODO! Make Run menu nice
# TODO! Make neovim nice
# TODO! Make Sway nice
#   (Nice Background)
#   (Borders etc)
#   (Master Slave layout)
#   (Blurred translucent on unfocused)
#   (Opaque on focused)
# TODO! Make Browser nice
# TODO! Low battery notification
# TODO! Fix qutebrowser crashing
# TODO! Fix qutebrowser not working with SEB, Ladok etc ...
# TODO! Fix Volume Mute and Mic Mute Lights

# Discord and slack with vim keybinds (probably a bad idea)
{
        imports = [
                ./kitty.nix
                ./qutebrowser.nix 
                ./wofi.nix
        ];

        programs.jq.enable = true;

        services.swaync.enable = true;

        wayland.windowManager.sway = let
                modifier = "Mod4";
                terminal = "kitty";
                browser = "qutebrowser";
                audio = "pavucontrol";
                volUp = "pamixer -i 5 --set-limit 50";
                volDown = "pamixer -d 5";
                micVolUp = "pamixer --default-source -i 5 --set-limit 100";
                micVolDown = "pamixer --default-source -d 5";
                volSwitchMute = "pamixer -t";
                micSwitchMute = "pamixer --default-source -t";
                brightnessGamma = "2";
                brightnessDown = "brightnessctl s 25%- -e ${brightnessGamma} -n 1";
                brightnessUp = "brightnessctl s +25% -e ${brightnessGamma} -n 1";
                brightnessNotification = let
                        brightness = "$(brightnessctl g | awk -v max=\"$(brightnessctl m)\" '{ printf \"%.0f\", ($1/max)^(1/${brightnessGamma})*100 }')";
                in
                        notification "Brightness ${brightness}%";
                notification = s: "exec notify-send -t 2000 \"${s}\"";
                sinkNotification = let
                        vol = "$(pamixer --get-volume)";
                        sink = "$(pamixer --list-sinks | grep Running | awk -F'\"' '{print $6}')";
                        muted = "$(pamixer --get-mute | awk '{print $1==\"true\" ? \"Muted \" : \"\"}')";
                in
                        notification "${vol}% ${muted}${sink}";
                micNotification = let 
                        vol = "$(pamixer --default-source --get-volume)";
                        mic = "$(pamixer --list-sources | grep Running | awk -F'\"' '{print $6}')";
                        muted = "$(pamixer --default-source --get-mute | awk '{print $1==\"true\" ? \"Muted \" : \"\"}')";
                in
                        notification "${vol}% ${muted}${mic}";
                batStat = "$(cat /sys/class/power_supply/BAT0/status)";
                batCap = "$(cat /sys/class/power_supply/BAT0/capacity)";
                batNotification = notification "${batStat} ${batCap}%";
                dateTime = "$(date '+%A %d %H:%M\')";
                dateTimeNotification = notification dateTime;
                currentWorkspace = "$(swaymsg -t get_workspaces -r | jq '.[] | select(.focused) | .num')";
                workspaceNotification = notification "Workspace ${currentWorkspace}";
                # TODO! Current workspace notification.
                privateBrowser = "qutebrowser --target private-window";
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
                                # TODO! Fix fcitx5 not working in discord.
                                # Maybe making a manual keybind will fix it! 
                                { command = "fcitx5"; always = true; }
                                # TODO! fix auto tiler. Maybe it has to do with fallof thingy option.
                                { command = "swaymonad --default-layout tall"; always = true; }
                                { command = "swaync"; always = true; }
                                { command = "swaylock"; always = true; }
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
                        focus.wrapping = "no"; # how to wrap around edge
                        input = {
                                "type:touchpad" = {
                                        natural_scroll = "enabled";
                                        tap = "enabled";
                                };
                                # see sway-input(5) for options
                        };
                        # Replace caps-lock with escape or shift or whatever
                        # Start sway automatically. Because of encryption thingie we could
                        # just omitt the password I think.
                        keybindings = {
                                "${modifier}+Return" = "exec ${terminal}";
                                "${modifier}+Space" = "exec ${menu}";
                                "${modifier}+q" = "exec ${browser}";
                                "${modifier}+p" = "exec ${privateBrowser}";
                                "${modifier}+Print" = "exec slurp | grim -g - - | wl-copy";
                                "${modifier}+f9" = "exec ${audio}";
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
                                "${modifier}+1" = "workspace number 1; exec ${workspaceNotification}";
                                "${modifier}+2" = "workspace number 2; exec ${workspaceNotification}";
                                "${modifier}+3" = "workspace number 3; exec ${workspaceNotification}";
                                "${modifier}+4" = "workspace number 4; exec ${workspaceNotification}";
                                "${modifier}+5" = "workspace number 5; exec ${workspaceNotification}";
                                "${modifier}+6" = "workspace number 6; exec ${workspaceNotification}";
                                "${modifier}+7" = "workspace number 7; exec ${workspaceNotification}";
                                "${modifier}+8" = "workspace number 8; exec ${workspaceNotification}";
                                "${modifier}+9" = "workspace number 9; exec ${workspaceNotification}";
                                "${modifier}+0" = "workspace number 10; exec ${workspaceNotification}";
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
                                "XF86MonBrightnessDown" = "exec ${brightnessDown} && ${brightnessNotification}";
                                "XF86MonBrightnessUp" = "exec ${brightnessUp} && ${brightnessNotification}";
                                "XF86AudioRaiseVolume" = "exec ${volUp} && ${sinkNotification}";
                                "XF86AudioLowerVolume" = "exec ${volDown} && ${sinkNotification}";
                                "${modifier}+XF86AudioRaiseVolume" = "exec ${micVolUp} && ${micNotification}";
                                "${modifier}+XF86AudioLowerVolume" = "exec ${micVolDown} && ${micNotification}";
                                "XF86AudioMute" = "exec ${volSwitchMute} && ${sinkNotification}";
                                "XF86AudioMicMute" = "exec ${micSwitchMute} && ${micNotification}";
                                "${modifier}+b" = "exec ${batNotification}";
                                "${modifier}+t" = "exec ${dateTimeNotification}";
                                # change mirror screen on button press is on nixos wiki for sway under tips and tricks.
                                # Keybind for notification of activity bar
                                # Iterate through mic keybind (notification)
                                # Iterate through speaker keybind (notification)
                                # Switch language (notification) (Caps-lock so you can see which it is)
                                # Battery-, Network-, Time-, Keybinds-, Sound-, notif on keybind
                                # See keybinds keybind (tell people this when using computer). No timer on notif. Tall notif.
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
                                hideEdgeBorders = "both";
                                titlebar = false;
                        };
                        workspaceAutoBackAndForth = true;
                        workspaceLayout = "default";
                        workspaceOutputAssign = [
                                {
                                        output = "eDP";
                                        workspace = "workspace number 2";
                                }
                        ];
                };
                # extraConfig = "";
                # extraConfigEarly = "";
                # extraOptions = [
                #       "--unsupported-gpu"
                #       etc ...
                # ];
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
