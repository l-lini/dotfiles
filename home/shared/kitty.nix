{ ... }:

{
        programs.kitty = {
                enable = true;
                settings = {
                        enable_audio_bell = false;
                        font_family = "Comic Mono";
			font_style = "Bold";
                        font_size = 20.0;
                        # clear_all_mouse_actions = "yes"; Disables mouse:
                        scrollback_pager = "nvim --cmd 'set eventignore=FileType' +'nnoremap q ZQ' +'call nvim_open_term(0, {})' +'set nomodified nolist' +'$' -";
                };
        };
}
# Command history Search. Me forgor often );
# Comic mono (better readability)
# tmux ?
# Fully fledged Vim Motions (Select text etc ...)
