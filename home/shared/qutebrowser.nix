{ pencils, ... }:
# TODO
# disable arrow keys outside of passthrough mode

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      fonts.default_size = "24px";
      fonts.default_family = "Comic Mono";
      colors = with pencils; {
        webpage.darkmode.enabled = true;
        completion = {
          fg = "#${black}";
          odd.bg = "#${black}";
          even.bg = "#${black}";
          category = {
            fg = "#${blue}";
            bg = "#${black}";
            border = {
              top = "#${black}";
              bottom = "#${black}";
            };
          };
          item.selected = {
            fg = "#${black}";
            bg = "#${bright.black}";
            border.top = "#${bright.black}";
            border.bottom = "#${bright.black}";
            match.fg = "#${bright.red}";
          };
          match.fg = "#${bright.red}";
          scrollbar = {
            fg = "#${bright.black}";
            bg = "#${black}";
          };
        };

        contextmenu = {
          disabled.bg = "#${black}";
          disabled.fg = "#${bright.black}";
          menu.bg = "#${black}";
          menu.fg = "#${black}";
          selected.bg = "#${bright.black}";
          selected.fg = "#${black}";
        };

        downloads = {
          bar.bg = "#${black}";
          start.fg = "#${black}";
          start.bg = "#${blue}";
          stop.fg = "#${black}";
          stop.bg = "#${green}";
          error.fg = "#${yellow}";
        };

        hints = {
          fg = "#${black}";
          bg = "#${yellow}";
          match.fg = "#${green}";
        };

        keyhint = {
          fg = "#${black}";
          suffix.fg = "#${yellow}";
          bg = "#${black}";
        };

        messages = {
          error.fg = "#${yellow}";
          error.bg = "#${black}";
          error.border = "#${yellow}";
          warning.fg = "#${bright.yellow}";
          warning.bg = "#${black}";
          warning.border = "#${bright.yellow}";
          info.fg = "#${black}";
          info.bg = "#${black}";
        };

        prompts = {
          fg = "#${black}";
          border = "#${bright.black}";
          bg = "#${black}";
          selected.bg = "#${bright.black}";
          selected.fg = "#${black}";
        };

        statusbar = {
          normal.fg = "#${blue}";
          normal.bg = "#${black}";
          insert.fg = "#${green}";
          insert.bg = "#${bright.black}";
          passthrough.fg = "#${blue}";
          passthrough.bg = "#${bright.black}";
          private.fg = "#${magenta}";
          private.bg = "#${bright.black}";
          command.fg = "#${black}";
          command.bg = "#${black}";
          command.private.fg = "#${magenta}";
          command.private.bg = "#${bright.black}";
          caret.fg = "#${magenta}";
          caret.bg = "#${bright.black}";
          caret.selection.fg = "#${cyan}";
          caret.selection.bg = "#${bright.black}";
          progress.bg = "#${blue}";
          url.fg = "#${black}";
          url.error.fg = "#${yellow}";
          url.hover.fg = "#${cyan}";
          url.success.http.fg = "#${bright.red}";
          url.success.https.fg = "#${green}";
          url.warn.fg = "#${bright.yellow}";
        };

        tabs = {
          bar.bg = "#${black}";
          indicator.start = "#${blue}";
          indicator.stop = "#${green}";
          indicator.error = "#${yellow}";
          odd.fg = "#${bright.black}";
          odd.bg = "#${bright.black}";
          even.fg = "#${bright.black}";
          even.bg = "#${bright.black}";
          pinned.even.bg = "#${bright.black}";
          pinned.even.fg = "#${bright.black}";
          pinned.odd.bg = "#${bright.black}";
          pinned.odd.fg = "#${bright.black}";
          pinned.selected.even.fg = "#${black}";
          pinned.selected.even.bg = "#${magenta}";
          pinned.selected.odd.fg = "#${black}";
          pinned.selected.odd.bg = "#${magenta}";
          selected.odd.fg = "#${black}";
          selected.odd.bg = "#${magenta}";
          selected.even.fg = "#${black}";
          selected.even.bg = "#${magenta}";
        };

        tooltip = {
          bg = "#${black}";
          fg = "#${black}";
        };
      };
    };
  };
}
