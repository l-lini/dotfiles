# TODO Command history Search. Me forgor often ); CTRL-R???
# TODO tmux ?
# TODO Fully fledged Vim Motions (Select text etc ...)
# TODO remove mouse from kitty
# TODO same theme in neovim

{ util, config, ... }:

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
    // (with util.pencil; rec {
      foreground = "#${text}";
      background = "#${void}";
      color0 = "#${ground}";
      color1 = "#${error}";
      color2 = "#${good}";
      color3 = "#${keyword}";
      color4 = "#${keyword}";
      color5 = "#${keyword}";
      color6 = "#${keyword}";

      color7 = text;
      cursor_text_color = void;

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
      url_color = "#${keyword}";
    });
  };
}
