{ ... }:
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
# TODO! Make Browser nice
# TODO! Low battery notification
# TODO! Fix qutebrowser crashing
# TODO! Fix qutebrowser not working with SEB, Ladok etc ...
# TODO! Fix Volume Mute and Mic Mute Lights
# TODO! Fix notification delay (send a notification on boot with a nice message! emojis and stuff!)
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
          {
            command = "spotify";
            always = true;
          }
        ];
        bars = [ ];
        defaultWorkspace = "workspace number 1";
        floating = {
          criteria = [ ];
          modifier = "Mod4";
          border = 0;
          titlebar = false;
        };
        input."type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
        keybindings = ({
          "Mod4+Return" = "exec kitty";
          "Mod4+Space" = "exec wofi --show run";
          "Mod4+b" = "exec qutebrowser";
          "Mod4+p" = "exec qutebrowser --target private-window";
          "Mod4+Backspace" = "kill";
          #"Mod4+f" = "fullscreen toggle";
          "Mod4+h" = "focus left";
          "Mod4+l" = "focus right";
          "Mod4+k" = "focus up";
          "Mod4+j" = "focus down";
          "Mod4+w" = "exec ${notificationFromBash "workspace-status"}";
          "Mod4+1" = "workspace number 1";
          "Mod4+2" = "workspace number 2";
          "Mod4+3" = "workspace number 3";
          "Mod4+Shift+1" = "move to workspace number 1";
          "Mod4+Shift+2" = "move to workspace number 2";
          "Mod4+Shift+3" = "move to workspace number 3";
          "Mod4+t" = "exec ${notificationFromBash "date-status"}";
          "Mod4+v" = "exec ${notificationFromBash "sink-volume"}";
        });
        seat."*".hide_cursor = "when-typing enable";
        window = {
          border = 0;
          titlebar = false;
        };
      };
      xwayland = true;
    };
}
