{ ... }:
# Make stuff look nice: (Comic Font for readability) (Nice Colorscheme) (Simple)
# TODO! Make Login nice
# TODO! Make Launcher nice
# TODO! Make Launcher always on top
# TODO! Make neovim nice
# TODO! Make Audio Interface nice (Pipewire thingy instead?)
# TODO! Make Network Interface nice
# TODO! Make Sway nice
#   TODO! Better JA Font
#   TODO! (Nice Notifications)
#   TODO! (Nice Background)
#   TODO! (Borders etc)
#   TODO! Fix AutoTiler (Master Slave layout)
#   TODO! (Blurred translucent on unfocused)
#   TODO! (Opaque on focused)
# TODO! Make Browser nice
# TODO! Low battery notification
# TODO! Fix qutebrowser crashing
# TODO! Fix qutebrowser not working with SEB, Ladok etc ...
# TODO! Fix Volume Mute and Mic Mute Lights
# TODO! Fix notification delay
# TODO! Replace Caps-Lock
# TODO! Vim Discord
# TODO! Vim Slack
{
        imports = [
                ./kitty.nix
                ./qutebrowser.nix 
                ./wofi.nix
        ];

        programs.jq.enable = true;

        services.swaync.enable = true;

        wayland.windowManager.sway = let
                commands = rec {
                        brightness = rec {
                                gamma = "2";
                                get = "brightnessctl g | awk -v max=\"$(brightnessctl m)\" '{ printf \"%.0f\", ($1/max)^(1/${gamma})*100 }'";
                                change = delta: "brightnessctl s ${delta} -e ${gamma} -n 1";
                                delta = "25%";
                                down = change "${delta}-";
                                up = change "+${delta}";
                        };
                        start = {
                                terminal = "kitty";
                                browser = "qutebrowser";
                                privateBrowser = "qutebrowser --target private-window";
                                audio = "pavucontrol";
                                autotiler = "autotiling -l 2";
                                notification = "swaync";
                                lock = "swaylock";
                                launcher = "wofi --show run";
                                screenshot = "slurp | grim -g - - | wl-copy";
                        };
                        move = delta: fetchOneCommand: fetchAllCommand:
                                "bash -c '"
                                + "mapfile -t arr < <(" + wrapCommand fetchAllCommand + "); "
                                + "l=$\{#arr[@]}; "
                                + "for ((i=0; i<l; i++)); do "
                                + "  if [[ \"$\{arr[i]}\" == $(" + wrapCommand fetchOneCommand + ") ]]; then "
                                + "    prev=$(((i + " + toString delta + " + l) % l)); "
                                + "    echo \"$\{arr[prev]}\"; "
                                + "    break; "
                                + "  fi; "
                                + "done"
                                + "'";
                        prev = move (-1);
                        next = move 1;
                        sed = {
                                fromTo = from: to: "sed -n '/${from}/,/${to}/ {p; /${to}/q}'";
                                numbers = "sed -nE 's/^[^0-9]*([0-9]+)\\..*/\\1/p'";
                                number = "sed -nE 's/^[^*]*\\* *([0-9]+)\\..*/\\1/p'";
                                muted = "sed -n 's/.*\\(MUTED\\).*/\\1/p'";
                                volume = "sed -nE ' /\\*/{ s/.*Volume: *([0-9.]+)\\].*/\\1/p }'";
                                name = "sed -nE 's/^[^*]*\\* *[0-9]+\\. *(.*) *\\[vol:.*/\\1/p'";
                        };
                        awk = {
                                toPercent = "awk '{ vol = int($1 * 100) } END { printf \"%d%%\", vol }'";
                        };
                        wpctl = rec {
                                get = rec {
                                        status = "wpctl status";
                                        sinkLines = "${status} | ${sed.fromTo "Sinks:" "Sources:"}";
                                        sourceLines = "${status} | ${sed.fromTo "Sources:" "Filters:"}";
                                        deviceLines = "${status} | ${sed.fromTo "Sinks:" "Filters:"}";
                                        sourceIds = "${sourceLines} | ${sed.numbers}";
                                        sourceId = "${sourceLines} | ${sed.number}";
                                        sinkIds = "${sinkLines} | ${sed.numbers}";
                                        sinkId = "${sinkLines} | ${sed.number}";
                                        deviceLine = idCommand: "${deviceLines} | grep ${wrapCommand idCommand}";
                                        volume = idCommand: "wpctl get-volume ${wrapCommand idCommand} | ${sed.volume} | ${awk.toPercent}";
                                        muted = idCommand: "wpctl get-volume ${wrapCommand idCommand} | ${sed.muted}";
                                        volumeAndMuted = idCommand: "echo \"$(${volume idCommand}) $(${muted idCommand})\"";
                                        name = idCommand: "${deviceLine idCommand} | ${sed.name}";
                                        stat = idCommand: "echo \"$(${volumeAndMuted idCommand}) $(${name idCommand})\"";
                                };
                                set = rec {
                                        volume = idCommand: delta: max: "wpctl set-volume ${wrapCommand idCommand} ${delta} -l ${max}";
                                        volumeUp = idCommand: delta: volume idCommand "${delta}+";
                                        volumeDown = idCommand: delta: volume idCommand "${delta}-";
                                        mute = idCommand: "wpctl set-mute ${wrapCommand idCommand} toggle";
                                        set = idCommand: "wpctl set-default ${wrapCommand idCommand}";
                                };
                                sink = f get.sinkId "0.5" "0.05";
                                source = f get.sourceId "1" "0.1";
                                f = idCommand: max: delta: rec {
                                        inherit max delta;
                                        volumeUp = set.volumeUp idCommand delta max;
                                        volumeDown = set.volumeDown idCommand delta max;
                                        mute = set.mute idCommand;
                                        volumeAndMuted = get.volumeAndMuted idCommand;
                                        stat = get.stat idCommand;
                                };
                        };
                        battery = let dir = "/sys/class/power_supply/BAT0"; in rec {
                                status = "cat ${dir}/status";
                                capacity = "cat ${dir}/capacity";
                                stat = "echo \"$(${status}) $(${capacity})%\"";
                        };
                        notification = rec {
                                fromCommand = command: { time ? "4000", ... }: "notify-send -t ${time} \"$(${command})\"";
                                dateTime = fromCommand date.all {};
                                battery = fromCommand commands.battery.stat {};
                                sink = {
                                        stat = fromCommand wpctl.sink.stat {};
                                        volumeAndMuted = fromCommand wpctl.sink.volumeAndMuted {}; # TODO Maybe Add "Speaker: "
                                };
                                source = {
                                        stat = fromCommand wpctl.source.stat {};
                                        volumeAndMuted = fromCommand wpctl.source.volumeAndMuted {}; # TODO Maybe Add "Microphone: "
                                };
                                workspace = fromCommand commands.workspace {};
                        };
                        date = rec {
                                day     = "date '+%d日'";
                                time = "date '+%H時%M分%S秒'";
                                weekday =
                                        "bash -c 'ns=(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日); " +
                                        "ks=(にちようび げつようび かようび すいようび もくようび きんようび どようび); " +
                                        "i=$(date +%w); echo \"$\{ns[$i]}: $\{ks[$i]}\"'";
                                all = "echo \"$(${day}) $(${weekday}) $(${time})\"";
                        };
                        workspace = "swaymsg -t get_workspaces -r | jq '.[] | select(.focused) | .num'";
                };
                keys = {
                        modifier = "Mod4";
                        resize = "Ctrl";
                        move = "Shift";
                        left = "h";
                        down = "j";
                        up = "k";
                        right = "l";
                };
                wrapCommand = s: "$(${s})";
        in {
                enable = true;
                config = rec {
                        startup = with commands.start; [
                                # TODO! Fix fcitx5 not working in discord. Maybe making a manual keybind will fix it! 
                                { command = "fcitx5"; always = true; }
                                { command = autotiler; always = true; }
                                { command = notification; always = true; }
                                { command = lock; always = false; }
				{ command = "swayidle -w lock " + lock; always = true; }
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
                                placeholder = idk;     # when restoring layouts?
                                urgent = idk;          # urgency hint active
                                unfocused = unfocused; # non-active window
                                focused = focused;     # active window
                        };
                        defaultWorkspace = "workspace number 1";
                        floating.border = 2;
                        floating.criteria = []; # list of attributes to be floating
                        floating.modifier = keys.modifier;
                        floating.titlebar = false;
                        focus.followMouse = true;
                        focus.mouseWarping = true;
                        focus.newWindow = "smart"; # smart, urgent, focus or none
                        focus.wrapping = "no"; # ???
                        input = {
                                "type:touchpad" = {
                                        natural_scroll = "enabled";
                                        tap = "enabled";
                                };
                        };
                        keybindings = (with commands.start; with keys; {
                                "${modifier}+Return" = "exec ${terminal}";
                                "${modifier}+Space" = "exec ${launcher}";
                                "${modifier}+q" = "exec ${browser}";
                                "${modifier}+p" = "exec ${privateBrowser}";
                                "Print" = "exec ${screenshot}";
                                "f9" = "exec ${audio}";
                        }) // (with commands; with keys; {
                                "${modifier}+Backspace" = "kill";
                                "${modifier}+f" = "fullscreen toggle";
                                "${modifier}+o" = "floating toggle";
                                "${modifier}+${resize}+${left}" = "resize shrink width 100 px";
                                "${modifier}+${resize}+${right}" = "resize grow width 100 px";
                                "${modifier}+${resize}+${up}" = "resize grow height 100 px";
                                "${modifier}+${resize}+${down}" = "resize shrink height 100 px";
                                "${modifier}+${move}+${left}" = "move left";
                                "${modifier}+${move}+${right}" = "move right";
                                "${modifier}+${move}+${up}" = "move up";
                                "${modifier}+${move}+${down}" = "move down";
                                "${modifier}+${left}" = "focus left";
                                "${modifier}+${right}" = "focus right";
                                "${modifier}+${up}" = "focus up";
                                "${modifier}+${down}" = "focus down";
                                "${modifier}+f9" = "exec ${notification.workspace}";
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
                                "${modifier}+${move}+1" = "move to workspace number 1";
                                "${modifier}+${move}+2" = "move to workspace number 2";
                                "${modifier}+${move}+3" = "move to workspace number 3";
                                "${modifier}+${move}+4" = "move to workspace number 4";
                                "${modifier}+${move}+5" = "move to workspace number 5";
                                "${modifier}+${move}+6" = "move to workspace number 6";
                                "${modifier}+${move}+7" = "move to workspace number 7";
                                "${modifier}+${move}+8" = "move to workspace number 8";
                                "${modifier}+${move}+9" = "move to workspace number 9";
                                "${modifier}+${move}+0" = "move to workspace number 10";
                                "XF86MonBrightnessDown" = "exec ${brightness.down}";
                                "XF86MonBrightnessUp" = "exec ${brightness.up}";
                                "${modifier}+b" = "exec ${notification.battery}";
                                "${modifier}+t" = "exec ${notification.dateTime}";
                        }) // (with commands; with wpctl; with keys; {
                                "${modifier}+Right" = "exec ${notification.fromCommand (next get.sinkId get.sinkIds) {}}";
                                "${modifier}+Left" = "exec ${notification.fromCommand (prev get.sinkId get.sinkIds) {}}";
                                "XF86AudioRaiseVolume" = "exec ${sink.volumeUp} && ${notification.sink.volumeAndMuted}";
                                "XF86AudioLowerVolume" = "exec ${sink.volumeDown} && ${notification.sink.volumeAndMuted}";
                                "${modifier}+XF86AudioRaiseVolume" = "exec ${source.volumeUp} && ${notification.source.volumeAndMuted}";
                                "${modifier}+XF86AudioLowerVolume" = "exec ${source.volumeDown} && ${notification.source.volumeAndMuted}";
                                "XF86AudioMute" = "exec ${sink.mute} && ${notification.sink.volumeAndMuted}";
                                "XF86AudioMicMute" = "exec ${source.mute} && ${notification.source.volumeAndMuted}";
                        });
                        # change mirror screen on button press is on nixos wiki for sway under tips and tricks.
                        # Keybind for notification of activity bar
                        # Iterate through mic keybind (notification)
                        # Iterate through speaker keybind (notification)
                        # Switch language (notification) (Caps-lock so you can see which it is)
                        # Network keybind (AirplaneMode button)
                        # See keybinds keybind. No Timer. Tall.
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
