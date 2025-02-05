{ config, pkgs, modulesPath, ... }:

{
  boot = {
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    #initrd.kernelModules = [ "dm-snapshot" ];
    initrd.kernelModules = [ ];
    # kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_6_12; #kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "kvm.enable_virt_at_load=0" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = let
      luks_root_uuid = "a6f03b03-af9e-479f-b7b5-fa4b37b4ce4b";
    in {
      # LUKS container with root partition
      "luks-${luks_root_uuid}" = {
        device = "/dev/disk/by-uuid/${luks_root_uuid}";
        allowDiscards = true;
      };
    };
  };

  # Configuration for LUKS containers and key files
  environment.etc.crypttab.text = ''
    cryptslab1 UUID=1fa0b0d6-231b-484f-975e-bb20f0b6febd /root/slab1.key
    cryptslab2 UUID=122683dc-1b5b-45e6-9a6f-85def4e4d3c0 /root/slab2.key
  '';

  # swapDevices = [{ 
  #     device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c";
      # device = "/swapfile";
      # size = 64 * 1024;
  #   }];

  fileSystems."/" =
    { device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home/whatever/mnt/slab1" =
    { device = "/dev/disk/by-label/slab1";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/slab2" =
    { device = "/dev/disk/by-label/slab2";
      fsType = "ext4";
    };
}
