{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./home-configuration/gnome-configuration.nix
      ./home-configuration/starship-configuration.nix
    ];

  # Home Manager configuration options go here
  home = {
    username = "whatever";
    homeDirectory = "/home/whatever";
    stateVersion = "24.11";
    packages = with pkgs; [
      docker
      dropbox
      easytag
      #floorp
      gnome-screenshot
      keepassxc
      libreoffice
      #librewolf
      nicotine-plus
      protonvpn-gui
      python3
      python311Packages.pip
      soundconverter
      # steam
      winbox
      wine
      # virtualbox
      vivaldi
      vlc
      yacreader
    ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      alias ll='ls -alhF'
      alias la='ls -A'
      alias l='ls -CF'
    '';
  };
}
