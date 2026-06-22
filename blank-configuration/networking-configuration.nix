{ config, pkgs, lib, modulesPath, ... }:

{
  networking = {
    hostName = "slab";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 8096 8920 9091 9000 ];
      allowedUDPPorts = [ 1900 7359 ];
    };
  };
}
