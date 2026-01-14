{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      daemon.settings.features.cdi = true;
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  users.groups.libvirtd.members = ["root" "whatever" ];
}