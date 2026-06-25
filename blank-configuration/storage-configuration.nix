{ config, modulesPath, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
      kernelModules = [ "dm-snapshot" ];
      systemd.enable = true;
      luks.devices = let
        luks_root_uuid = "99797e14-d02a-4073-b511-b8845fd0cef7";
      in {
        "luks-${luks_root_uuid}" = {
          device = "/dev/disk/by-uuid/${luks_root_uuid}";
          allowDiscards = true;
        };
      };
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "kvm.enable_virt_at_load=0" "fbcon=rotate:3" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment.etc.crypttab.text = ''
    cryptslab0 UUID=05c46ba4-7a88-4290-8754-11160e363fc /root/slab0.key
    cryptslab1 UUID=5fc74d13-c55e-4dba-b9c0-3ef1b9171b35 /root/slab1.key
    cryptslab2 UUID=37f13c22-7daa-4a82-a9e0-f4e639a85ef1 /root/slab2.key
    pod1 UUID=43e12ee9-b897-4fb8-95cf-19bef78a175e /root/pod1.key
    pod2 UUID=614ea1c4-8dcc-445b-af92-6501e873bfcc /root/pod2.key
  '';

  # swapDevices = [{ 
      # device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c";
      # device = "/swapfile";
      # size = 64 * 1024;
  #   }];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    # "/home/whatever/mnt/slab0" = {
    #   device = "/dev/disk/by-label/slab0";
    #   fsType = "ext4";
    # };
    "/home/whatever/mnt/slab1" = {
      device = "/dev/disk/by-label/slab1";
      fsType = "ext4";
    };
    "/home/whatever/mnt/slab2" = {
      device = "/dev/disk/by-label/slab2";
      fsType = "ext4";
    };
    # "/home/whatever/mnt/pod1" = {
    #   device = "/dev/disk/by-label/pod1";
    #   fsType = "ext4";
    #   neededForBoot = false;
    #   options = [
    #     "nofail"
    #   ];
    # };
    # "/home/whatever/mnt/pod2" = {
    #   device = "/dev/disk/by-label/pod2";
    #   fsType = "ext4";
    #   neededForBoot = false;
    #   options = [
    #     "nofail"
    #   ];
    # };
  };
}
