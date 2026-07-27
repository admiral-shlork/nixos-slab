{ config, lib, modulesPath, pkgs, ... }:

{
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
    nvidia-container-toolkit = {
      enable = true;
      package = pkgs.nvidia-docker;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    xserver.videoDrivers = ["nvidia"];
    blueman.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = { 
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  systemd.services.nvidia-control-devices = {
    wantedBy = [
      "multi-user.target"
    ];
    script = "/run/current-system/sw/bin/nvidia-smi";
  };

  security.rtkit.enable = true;
}
