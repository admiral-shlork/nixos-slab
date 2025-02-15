{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "slab";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 8096 8920 9091 ];
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
}
