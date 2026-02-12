{ pencils, ... }:
# Make stuff look nice: (Comic Font for readability) (Nice Colorscheme) (Simple)
# TODO change mirror screen on button press is on nixos wiki for sway under tips and tricks.
# TODO Keybind for activity bar
# TODO Network status keybind
# TODO keybinds keybind
# TODO Fix double lock
# TODO! Make Login nice
# TODO! Make Launcher nice
# TODO! Make Launcher always on top
# TODO! Make neovim nice
# TODO! Make Audio Interface nice (Pipewire thingy instead?)
# TODO! Make Network Interface nice
# TODO! Make Sway nice
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
{
  imports = [
    ./kitty.nix
    ./qutebrowser.nix
    ./wofi.nix
  ];

  programs.jq.enable = true;

  services.swaync.enable = true;

  wayland.windowManager.sway =
    let
      notificationFromBash = notificationWithTime "4000";
      notificationWithTime =
        time: command: builtins.trace command "sh -c 'notify-send -t ${time} $(${command})'";
      keys = {
        modifier = "Mod4";
        resize = "Ctrl";
        move = "Shift";
        left = "h";
        down = "j";
        up = "k";
        right = "l";
      };
    in
    {
      enable = true;
      config = {
        startup = [
          {
            command = "fcitx5";
            always = true;
          }
          {
            command = "autotiler";
            always = true;
          }
          {
            command = "notification-daemon";
            always = true;
          }
        ];
        bars = [ ];
        colors =
          with pencils;
          let
            focused = {
              background = black;
              border = blue;
              childBorder = bright.blue;
              indicator = cyan;
              text = white;
            };

            unfocused = {
              background = bright.black;
              border = bright.yellow;
              childBorder = yellow;
              indicator = bright.cyan;
              text = white;
            };

            urgent = {
              background = red;
              border = red;
              childBorder = red;
              indicator = red;
              text = black;
            };

            placeholder = urgent; # For restoring layouts
            focusedInactive = urgent; # Placeholder mapping
          in
          {
            background = black;
            focusedInactive = focusedInactive;
            placeholder = placeholder;
            urgent = urgent;
            unfocused = unfocused;
            focused = focused;
          };
        defaultWorkspace = "workspace number 1";
        floating.border = 2;
        floating.criteria = [ ]; # list of attributes to be floating
        floating.modifier = keys.modifier;
        floating.titlebar = false;
        focus.followMouse = true;
        focus.mouseWarping = true;
        # focus.newWindow = "smart"; # smart, urgent, focus or none
        input."type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
        keybindings =
          (with keys; {
            "${modifier}+Return" = "exec kitty";
            "${modifier}+Space" = "exec wofi --show run";
            "${modifier}+b" = "exec qutebrowser";
            "${modifier}+p" = "exec qutebrowser --target private-window";
          })
          // (with keys; {
            "${modifier}+Backspace" = "kill";
            "${modifier}+f" = "fullscreen toggle";
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
            "${modifier}+w" = "exec ${notificationFromBash "workspace-status"}";
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
            "${modifier}+t" = "exec ${notificationFromBash "date-status"}";
            "${modifier}+v" = "exec ${notificationFromBash "sink-volume"}";
          });
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
        # workspaceAutoBackAndForth = true;
      };
      xwayland = true;
    };
}
