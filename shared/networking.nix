{ hostName, secrets, ... }:

{
	networking = {
        firewall.enable = false;
        hostId = "e16f9e84"; # used by zfs
        hostName = hostName;
        networkmanager = {
            enable = true;
            ensureProfiles.profiles = let
                createWifi = ssid: {
                    connection = {
                        id = ssid;
                        type = "wifi";
                        interface-name = "wlp0s20f3";
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
            in {
                Merkurius = createWifi "Merkurius";
                Lini = createWifi "Lini";
                eduroam = with createWifi "eduroam"; {
                    inherit wifi connection ipv4 ipv6;
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
    };
}
