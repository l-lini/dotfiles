{
  inputs,
  disko-device,
  filesystem,
  encryption,
  ...
}:

{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = disko-device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
          }
          // (
            if filesystem == "zfs" then
              {
                zfs = {
                  size = "100%";
                  content = {
                    type = "zfs";
                    pool = "rpool";
                  };
                };
              }
            else if filesystem == "btrfs" then
              {
                root = {
                  size = "100%";
                  content = {
                    type = "btrfs";
                    mountpoint = "/";
                    mountOptions = [
                      "compress= zstd"
                      "noatime"
                    ];
                  };
                };
              }
            else
              builtins.abort "filesystem has to be either btrfs or zfs not ${filesystem}"
          );
        };
      };
    };
  }
  // (
    if filesystem == "zstd" then
      {
        zpool = {
          rpool = {
            type = "zpool";
            rootFsOptions = {
              mountpoint = "none";
              compression = "zstd";
            };
            datasets = {
              "nixos/empty" = {
                type = "zfs_fs";
                options = {
                  mountpoint = "legacy";
                }
                // (
                  if builtins.isString encryption then
                    {
                      inherit encryption;
                    }
                  else
                    { }
                );
                mountpoint = "/";
                postCreateHook = "zfs snapshot rpool/nixos/empty@start";
              };
              "nixos/home" = {
                type = "zfs_fs";
                options.mountpoint = "legacy";
                mountpoint = "/home";
              };
              "nixos/stay" = {
                type = "zfs_fs";
                options.mountpoint = "legacy";
                mountpoint = "/stay";
              };
              "nixos/nix" = {
                type = "zfs_fs";
                options.mountpoint = "legacy";
                mountpoint = "/nix";
              };
            };
          };
        };
      }
    else
      { }
  );
}
