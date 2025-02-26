{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      extraOptions = "--runtime=nvidia";
    };
  };
  users.groups.libvirtd.members = ["root" "whatever" ];
}
