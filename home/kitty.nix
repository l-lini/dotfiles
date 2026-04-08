# TODO Command history Search. Me forgor often ); CTRL-R???
# TODO tmux ?
# TODO Fully fledged Vim Motions (Select text etc ...)
# TODO remove mouse from kitty

{ pencils, config, ... }:

{
  programs.zsh.initContent = config.programs.zsh.shellInit;

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      font_family = "Comic Mono";
      font_style = "Bold";
      font_size = 19.0;
      # clear_all_mouse_actions = "yes";
    }
    // (with pencils; rec {
      foreground = "#${white}";
      background = "#${black}";
      color0 = "#${bright.black}";
      color1 = "#${red}";
      color2 = "#${green}";
      color3 = "#${yellow}";
      color4 = "#${blue}";
      color5 = "#${magenta}";
      color6 = "#${cyan}";

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
      url_color = "#${bright.red}";
    });
  };
}
