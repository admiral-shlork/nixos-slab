{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      extraOptions = "--default-runtime=nvidia";
    };
  };
  users.groups.libvirtd.members = ["root" "whatever" ];
}
