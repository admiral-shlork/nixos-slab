{ config, lib, pkgs, ... }:
{
  services = {
    xserver.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    openssh.enable = true;
    udev.packages = with pkgs; [ gnome-settings-daemon ];
    prometheus.exporters.node = {
      enable = true;
      port = 9000;
      enabledCollectors = [
        "cpu"
        "cpufreq"
        "diskstats"
        "ethtool"
        "filesystem"
        "hwmon"
        "loadavg"
        "meminfo"
        "nvme"
        "os"
        "softirqs"
        "systemd"
        "vmstat"
      ];
      extraFlags = [ "--collector.ntp.protocol-version=4" "--no-collector.mdadm" ];
    };
  };

  programs = {
    firefox.enable = true;
    direnv.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      appimage-run
      bitcoin
      brlaser
      btop
      dconf-editor
      docker
      dropbox
      ghostty
      git
      gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-panel
      gnomeExtensions.date-menu-formatter
      gnomeExtensions.night-theme-switcher
      gnomeExtensions.no-overview
      home-manager
      keepassxc
      libreoffice
      nh
      nicotine-plus
      nvidia-container-toolkit
      nvidia-docker
      proton-vpn
      python3
      rustic
      screen
      veracrypt
      vim
      virt-manager
      vivaldi
      vlc
      vscodium
      wget
      winbox
      wine
      yacreader
    ];
    gnome.excludePackages = (with pkgs; [
      atomix
      cheese
      decibels
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
      showtime
      snapshot
      tali
      totem
      yelp
    ]);
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  systemd.services.prometheus-node-exporter.serviceConfig = {
    RestrictNamespaces = lib.mkForce false;
    ProtectHome = lib.mkForce false;
  };
}
