{ pencils, ... }:

{
  programs.kitty = {
    enable = true;
    settings = with builtins.mapAttrs (n: c: "#" + c) pencils; rec {
      enable_audio_bell = false;
      font_family = "Comic Mono";
      font_style = "Bold";
      font_size = 20.0;
      # clear_all_mouse_actions = "yes"; Disables mouse:

      foreground = white;
      background = black;
      color0 = bright.black;
      color1 = red;
      color2 = green;
      color3 = yellow;
      color4 = blue;
      color5 = magenta;
      color6 = cyan;

      color7 = foreground;
      cursor_text_color = background;

      color8 = color0;
      color9 = color1;
      color10 = color2;
      color11 = color3;
      color12 = color4;
      color13 = color5;
      color14 = color6;
      color15 = color7;
      cursor = color7;

      # Selection highlight
      selection_foreground = "none";
      selection_background = color0;

      # The color for highlighting URLs on mouse-over
      url_color = bright.red;

      # # Window borders
      # active_border_color = "#3d59a1";
      # inactive_border_color = "#101014";
      # bell_border_color = "#e0af68";

      # Tab bar
      # tab_bar_style = "fade";
      # tab_fade = 1;
      # active_tab_foreground = color0;
      # active_tab_background = baackground;
      # active_tab_font_style = "bold";
      # inactive_tab_foreground = "#787c99";
      # inactive_tab_background = "#16161e";
      # inactive_tab_font_style = "bold";
      # tab_bar_background = "#101014";

      # Title bar
      # macos_titlebar_color = "#16161e";
    };
  };
}
# Command history Search. Me forgor often );
# Comic mono (better readability)
# tmux ?
# Fully fledged Vim Motions (Select text etc ...)
