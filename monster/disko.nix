{ inputs, ... }:

{
	imports = [ inputs.disko.nixosModules.disko ];
          disko.devices = {
            disk = {
              main = {
                device = "/dev/disk/by-id/nvme-KINGSTON_SKC3000D2048G_50026B76860D859A";
                type = "disk";
                content = {
                  type = "gpt";
                  partitions = {
                    ESP = {
                      type = "EF00";
                      size = "1G";
                      content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                        mountOptions = [ "umask=0077" ];
                      };
                    };
                    root = {
                      size = "100%";
                      content = {
                        type = "btrfs";
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                    };
                  };
                };
              };
            };
          };
}
