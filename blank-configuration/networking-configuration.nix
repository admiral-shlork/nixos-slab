{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "slab";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 8096 ];
}
