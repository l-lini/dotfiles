{ pencils, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = with pencils; {
      # Background
      color = black;

      # Indicator (active ring)
      ring-color = blue;
      inside-color = bright.blue;
      line-color = cyan;

      # Idle / unfocused (verification)
      ring-ver-color = bright.black;
      inside-ver-color = bright.blue;
      line-ver-color = bright.cyan;

      # Wrong password (urgent)
      ring-wrong-color = red;
      inside-wrong-color = bright.red;
      line-wrong-color = bright.red;

      # Text
      text-color = white;
      text-ver-color = bright.white;
      text-wrong-color = black;

      # Layout / keyboard indicators
      layout-bg-color = black;
      layout-border-color = blue;
      layout-text-color = white;
    };
  };
}
