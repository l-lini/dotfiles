{ pencils, ... }:
# disable arrow keys outside of passthrough mode

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      fonts.default_size = "24px";
      fonts.default_family = "Comic Mono";
      colors = with pencils; {
        completion = {
          fg = tokyonight.fg;
          odd.bg = tokyonight.bg_dark;
          even.bg = tokyonight.bg;
          category = {
            fg = tokyonight.blue;
            bg = tokyonight.bg_dark;
            border = {
              top = tokyonight.bg_dark;
              bottom = tokyonight.bg_dark;
            };
          };
          item.selected = {
            fg = tokyonight.fg;
            bg = tokyonight.bg_visual;
            border.top = tokyonight.bg_visual;
            border.bottom = tokyonight.bg_visual;
            match.fg = tokyonight.orange;
          };
          match.fg = tokyonight.orange;
          scrollbar = {
            fg = tokyonight.fg_gutter;
            bg = tokyonight.bg_dark;
          };
        };

        contextmenu = {
          disabled.bg = tokyonight.bg_dark;
          disabled.fg = tokyonight.dark5;
          menu.bg = tokyonight.bg_popup;
          menu.fg = tokyonight.fg;
          selected.bg = tokyonight.bg_visual;
          selected.fg = tokyonight.fg;
        };

        downloads = {
          bar.bg = tokyonight.bg_statusline;
          start.fg = tokyonight.bg;
          start.bg = tokyonight.blue;
          stop.fg = tokyonight.bg;
          stop.bg = tokyonight.green;
          error.fg = tokyonight.error;
        };

        hints = {
          fg = tokyonight.bg;
          bg = tokyonight.yellow;
          match.fg = tokyonight.green;
        };

        keyhint = {
          fg = tokyonight.fg;
          suffix.fg = tokyonight.yellow;
          bg = tokyonight.bg_popup;
        };

        messages = {
          error.fg = tokyonight.error;
          error.bg = tokyonight.bg;
          error.border = tokyonight.error;
          warning.fg = tokyonight.warning;
          warning.bg = tokyonight.bg;
          warning.border = tokyonight.warning;
          info.fg = tokyonight.info;
          info.bg = tokyonight.bg;
        };

        prompts = {
          fg = tokyonight.fg;
          border = tokyonight.border_highlight;
          bg = tokyonight.bg_popup;
          selected.bg = tokyonight.bg_visual;
          selected.fg = tokyonight.fg;
        };

        statusbar = {
          normal.fg = tokyonight.blue;
          normal.bg = tokyonight.bg_statusline;
          insert.fg = tokyonight.green;
          insert.bg = tokyonight.bg_highlight;
          passthrough.fg = tokyonight.blue;
          passthrough.bg = tokyonight.bg_highlight;
          private.fg = tokyonight.purple;
          private.bg = tokyonight.bg_highlight;
          command.fg = tokyonight.fg;
          command.bg = tokyonight.bg_statusline;
          command.private.fg = tokyonight.purple;
          command.private.bg = tokyonight.bg_highlight;
          caret.fg = tokyonight.magenta;
          caret.bg = tokyonight.bg_highlight;
          caret.selection.fg = tokyonight.cyan;
          caret.selection.bg = tokyonight.bg_highlight;
          progress.bg = tokyonight.blue;
          url.fg = tokyonight.fg;
          url.error.fg = tokyonight.error;
          url.hover.fg = tokyonight.cyan;
          url.success.http.fg = tokyonight.orange;
          url.success.https.fg = tokyonight.green1;
          url.warn.fg = tokyonight.warning;
        };

        tabs = {
          bar.bg = tokyonight.black;
          indicator.start = tokyonight.blue;
          indicator.stop = tokyonight.green;
          indicator.error = tokyonight.error;
          odd.fg = tokyonight.dark3;
          odd.bg = tokyonight.bg_highlight;
          even.fg = tokyonight.dark3;
          even.bg = tokyonight.bg_highlight;
          pinned.even.bg = tokyonight.bg_highlight;
          pinned.even.fg = tokyonight.dark3;
          pinned.odd.bg = tokyonight.bg_highlight;
          pinned.odd.fg = tokyonight.dark3;
          pinned.selected.even.fg = tokyonight.bg;
          pinned.selected.even.bg = tokyonight.magenta;
          pinned.selected.odd.fg = tokyonight.bg;
          pinned.selected.odd.bg = tokyonight.magenta;
          selected.odd.fg = tokyonight.bg;
          selected.odd.bg = tokyonight.magenta;
          selected.even.fg = tokyonight.bg;
          selected.even.bg = tokyonight.magenta;
        };

        tooltip = {
          bg = tokyonight.bg_popup;
          fg = tokyonight.fg;
        };
      };
    };
  };
}
