{ username, ... }:

{
  services.fluidsynth = {
    enable = true;
    soundFont = "/home/${username}/Music/SoundFonts/Yamaha Grand-v2.1.sf2";
  };
}
