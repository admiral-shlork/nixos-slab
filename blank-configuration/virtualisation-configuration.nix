{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      extraOptions = "--gpus=all";
    };
  };
  users.groups.libvirtd.members = ["root" "whatever" ];
}
