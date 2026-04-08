{ pencils, ... }:
# TODO disable arrow keys outside of passthrough mode

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      fonts.default_size = "24px";
      fonts.default_family = "Comic Mono";
      colors = with pencils; {
        webpage.darkmode.enabled = true;
        completion = {
          fg = "#${white}";
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
            fg = "#${white}";
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
          selected.fg = "#${white}";
        };

        downloads = {
          bar.bg = "#${black}";
          start.fg = "#${white}";
          start.bg = "#${blue}";
          stop.fg = "#${white}";
          stop.bg = "#${green}";
          error.fg = "#${yellow}";
        };

        hints = {
          fg = "#${bright.white}";
          bg = "#${bright.black}";
          match.fg = "#${black}";
        };

        keyhint = {
          fg = "#${white}";
          suffix.fg = "#${yellow}";
          bg = "#${black}";
        };

        messages = {
          error.fg = "#${white}";
          error.bg = "#${black}";
          error.border = "#${yellow}";
          warning.fg = "#${bright.yellow}";
          warning.bg = "#${black}";
          warning.border = "#${bright.yellow}";
          info.fg = "#${white}";
          info.bg = "#${black}";
        };

        prompts = {
          fg = "#${white}";
          border = "#${bright.black}";
          bg = "#${black}";
          selected.bg = "#${bright.black}";
          selected.fg = "#${bright.white}";
        };

        statusbar = {
          normal.fg = "#${white}";
          normal.bg = "#${black}";
          insert.fg = "#${white}";
          insert.bg = "#${bright.black}";
          passthrough.fg = "#${blue}";
          passthrough.bg = "#${bright.black}";
          private.fg = "#${magenta}";
          private.bg = "#${bright.black}";
          command.fg = "#${white}";
          command.bg = "#${black}";
          command.private.fg = "#${magenta}";
          command.private.bg = "#${bright.black}";
          caret.fg = "#${magenta}";
          caret.bg = "#${bright.black}";
          caret.selection.fg = "#${cyan}";
          caret.selection.bg = "#${bright.black}";
          progress.bg = "#${blue}";
          url.fg = "#${white}";
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
          odd.fg = "#${white}";
          odd.bg = "#${black}";
          even.fg = "#${white}";
          even.bg = "#${black}";
          pinned.even.bg = "#${black}";
          pinned.even.fg = "#${bright.black}";
          pinned.odd.bg = "#${black}";
          pinned.odd.fg = "#${bright.black}";
          pinned.selected.even.fg = "#${black}";
          pinned.selected.even.bg = "#${magenta}";
          pinned.selected.odd.fg = "#${black}";
          pinned.selected.odd.bg = "#${magenta}";
          selected.odd.fg = "#${bright.white}";
          selected.odd.bg = "#${bright.black}";
          selected.even.fg = "#${bright.white}";
          selected.even.bg = "#${bright.black}";
        };

        tooltip = {
          bg = "#${black}";
          fg = "#${white}";
        };
      };
    };
  };
}
