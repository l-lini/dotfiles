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
            };
        };
    };
}
