# TODO Bluetooth auto connect to headphones
{ ... }:

{
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
