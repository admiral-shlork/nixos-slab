{ config, pkgs, ... }:
{
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.openssh.enable = true;

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.firefox.enable = true;
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run
    brlaser
    bitcoin
    git
    dconf-editor
    ghostty
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-panel
    gnomeExtensions.date-menu-formatter
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.no-overview
    home-manager
    htop
    nh
    terminator
    veracrypt
    vim
    virt-manager
    vscodium
    wget
  ];

  environment.gnome.excludePackages =
    (with pkgs; [
      atomix
      cheese
      epiphany
      evince
      geary
      gedit
      gnome-calendar
      gnome-characters
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-photos
      gnome-software
      gnome-terminal
      gnome-tour
      gnome-weather
      hitori
      iagno
      simple-scan
      snapshot
      tali
      totem
      yelp
    ]);

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];
}
