# zfs (disko)
# Encryption
{ ... }:

{
        disko.devices = {
                disk = {
                        root = {
                                type = "disk";
                                device = /dev/nvme0n1;
                                content = {
                                        type = "gpt";
                                        partitions = {
                                                ESP = {
                                                        size = "64M";
                                                        type = "EF00";
                                                        content = {
                                                                type = "filesystem";
                                                                format = "vfat";
                                                                mountpoint = /boot;
                                                                mountOptions = [ "umask=0077" ];
                                                        };
                                                };
                                                zfs = {
                                                        size = "100%";
                                                        content = {
                                                                type = "zfs";
                                                                pool = "zroot";
                                                        };
                                                };
                                        };
                                };
                        };
                };
                zpool = {
                        zroot = {
                                type = "zpool";
                                rootFsOptions = {
                                        mountpoint = "none";
                                        compression = "zstd";
                                        acltype = "posixacl";
                                        xattr = "sa";
                                        "com.sun:auto-snapshot" = "true";
                                };
                                options.ashift = "12";
                                datasets = {
                                        "root" = "zfs_fs";
                                        options = {
                                                encryption = "aes-256-gcm";
                                                keyformat = "passphrase";
                                                # keylocation = /home/lini/Secrets/encryption.key;
                                                keylocation = "prompt";
                                        };
                                };
                                mountpoint = /.;
                        };
                        "root/nix" = {
                                type = "zfs_fs";
                                options.mountpoint = /nix;
                                mountpoint = /nix;
                        };
                };
        };
}
