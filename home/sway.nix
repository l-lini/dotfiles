{
  sway-workspaces ? {
    "1" = null;
    "2" = null;
    "3" = null;
  },
  sway-startup ? [ ],
}:
{
  lib,
  ...
}:
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

  wayland.windowManager.sway = {
    enable = true;
    config = {
      startup = [
        {
          command = "autotiling -l 1";
          always = true;
        }
        {
          command = "swaync";
          always = true;
        }
      ]
      ++ sway-startup
      ++ (
        with builtins;
        map (app: {
          command = app;
          always = true;
        }) (filter isString (attrValues sway-workspaces))
      );
      assigns =
        with builtins;
        mapAttrs (_: app: [
          { class = lib.toUpper (substring 0 1 app) + substring 1 (stringLength app - 1) app; }
        ]) (lib.filterAttrs (_: s: isString s) sway-workspaces);
      bars = [ ];
      defaultWorkspace = "workspace number 1";
      floating = {
        modifier = "Mod4";
        border = 0;
        titlebar = false;
      };
      input."type:touchpad" = {
        natural_scroll = "enabled";
        tap = "enabled";
      };
      keybindings =
        with builtins;
        let
          generator =
            nameF: valueF: xs:
            listToAttrs (
              map (x: {
                name = nameF x;
                value = valueF x;
              }) xs
            );
          workspaces = attrNames sway-workspaces;
        in
        {
          "Mod4+Return" = "exec kitty";
          "Mod4+Space" = "exec wofi --show run";
          "Mod4+b" = "exec qutebrowser";
          "Mod4+p" = "exec qutebrowser --target private-window";
          "Mod4+Backspace" = "kill";
          "Mod4+h" = "focus left";
          "Mod4+l" = "focus right";
          "Mod4+k" = "focus up";
          "Mod4+j" = "focus down";
          "Mod4+w" = ''exec notify-send -t 3000 "$(workspace-status)"'';
          "Mod4+t" = ''exec notify-send -t 3000 "$(tid)"'';
          "Mod4+v" = ''exec notify-send -t 3000 "$(sink-volume)"'';
          "Mod4+s" = "exec systemctl sleep";
        }
        // generator (n: "Mod4+${n}") (n: "workspace number ${n}") workspaces
        // generator (n: "Mod4+Shift+${n}") (n: "move to workspace number ${n}") workspaces;
      seat."*".hide_cursor = "when-typing enable";
      window = {
        border = 0;
        titlebar = false;
      };
    };
    xwayland = true;
  };
}
