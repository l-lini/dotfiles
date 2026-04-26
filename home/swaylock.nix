{ util, ... }:

{
  programs.swaylock = {
    enable = true;

    settings = with util.pencil; {
      # Background
      color = void;

      # Indicator (active ring)
      ring-color = keyword;
      inside-color = variable;
      line-color = literal;

      # Idle / unfocused (verification)
      ring-ver-color = ground;
      inside-ver-color = function;
      line-ver-color = comment;

      # Wrong password (urgent)
      ring-wrong-color = bad;
      inside-wrong-color = bad;
      line-wrong-color = bad;

      # Text
      text-color = text;
      text-ver-color = text;
      text-wrong-color = bad;

      # Layout / keyboard indicators
      layout-bg-color = void;
      layout-border-color = ground;
      layout-text-color = text;
    };
  };
}
