# TODO Bluetooth auto connect to headphones
# TODO make sway require this audio module
{ pkgs, scripts, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pamixer
    scripts.audio-changes
    scripts.audio-status
    scripts.scroll-devices
    scripts.scroll-items
  ];

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
}
