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

      foreground = "#${util.pencil.text}";
      background = "#${util.pencil.void}";
      cursor_text_color = "#${util.pencil.void}";
      selection_foreground = "none";
      selection_background = "#${util.pencil.void}";
      url_color = "#${util.pencil.comment}";

    }
    // builtins.listToAttrs (
      builtins.genList (i: {
        name = "color${builtins.toString i}";
        value = "#${builtins.elemAt util.pencil.console_colors i}";
      }) (builtins.length util.pencil.console_colors)
    );
  };
}
