{ hostName, secrets, ... }:

{
	networking = {
        firewall.enable = false;
        hostId = "e16f9e84"; # used by zfs
        hostName = hostName;
        networkmanager = {
            enable = true;
            ensureProfiles.profiles = let
                createWifi = ssid: psk: {
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
                        inherit psk;
                    };
                    ipv4.method = "auto";
                    ipv6 = {
                        addr-gen-mode = "default";
                        method = "auto";
                    };
                };
            in {
                Merkurius = createWifi "Merkurius" secrets.Merkurius;
                Lini = {
                    connection = {
                        type = "wifi";
                        id = "Lini";
                    };
                };
            };
        };
    };
}
