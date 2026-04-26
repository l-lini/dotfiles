{
  config,
  lib,
  pkgs,
  hostId,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ ];
      systemd = {
        enable = true;
        services.initrd-rollback-root = {
          after = [ "zfs-import-rpool.service" ];
          wantedBy = [ "initrd.target" ];
          before = [
            "sysroot.mount"
          ];
          path = [ pkgs.zfs ];
          description = "Rollback root fs";
          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = "zfs rollback -r rpool/nixos/empty@start";
        };
      };
    };
  };

  networking.hostId = hostId; # lower-case 8 digit hexadecimal number used by zfs

  fileSystems."/stay".neededForBoot =  true;
  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
