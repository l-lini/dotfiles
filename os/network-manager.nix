{ secrets, ... }:

let
  createWifi = ssid: {
    connection = {
      id = ssid;
      type = "wifi";
    };
    wifi = {
      mode = "infrastructure";
      inherit ssid;
    };
    wifi-security = {
      auth-alg = "open";
      key-mgmt = "wpa-psk";
      psk = secrets.${ssid};
    };
    ipv4.method = "auto";
    ipv6 = {
      addr-gen-mode = "default";
      method = "auto";
    };
  };
in
{
  users.users.lini.extraGroups = [
    "networkmanager" # make declarative instead
  ];
  networking.networkmanager = {
    enable = true;
    ensureProfiles.profiles = {
      Merkurius = createWifi "Merkurius";
      Lini = createWifi "Lini";
      eduroam = with createWifi "eduroam"; {
        inherit
          wifi
          connection
          ipv4
          ipv6
          ;
        wifi-security.key-mgmt = "wpa-eap";
        "802-1x" = {
          eap = "peap";
          domain-suffix-match = "eduroam.chalmers.se";
          identity = "alteborn@chalmers.se";
          password = secrets.eduroam;
          phase2-auth = "mschapv2";
        };
      };
    };
  };
}
