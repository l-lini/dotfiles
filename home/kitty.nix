{ ... }:

{
        programs.kitty = {
                enable = true;
                settings = {
                        enable_audio_bell = false;
                        font_family = "Mona Sans";
                        font_size = 16.0;
                        # clear_all_mouse_actions = "yes";
                        scrollback_pager = "nvim --cmd 'set eventignore=FileType' +'nnoremap q ZQ' +'call nvim_open_term(0, {})' +'set nomodified nolist' +'$' -";
                };
        };
}
# Comic mono (better readability)
# tmux ?
# Disable mouse in terminal
# vim keybinds (So I can move around output easily witohut using less)
# Better vim keybinds than default kitty. Or maybe just learn them.
