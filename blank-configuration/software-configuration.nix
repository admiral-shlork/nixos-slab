{ config, pkgs, ... }:
{
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.openssh.enable = true;

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.firefox.enable = true;
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run
    brlaser
    btop
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
    nh
    nvidia-container-toolkit
    nvidia-docker
    rustic
    screen
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

  # https://nixos.org/manual/nixos/stable/#module-services-prometheus-exporters
  # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
  services.prometheus.exporters.node = {
    enable = true;
    port = 9000;
    # For the list of available collectors, run, depending on your install:
    # - Flake-based: nix run nixpkgs#prometheus-node-exporter -- --help
    # - Classic: nix-shell -p prometheus-node-exporter --run "node_exporter --help"
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
    # You can pass extra options to the exporter using `extraFlags`, e.g.
    # to configure collectors or disable those enabled by default.
    # Enabling a collector is also possible using "--collector.[name]",
    # but is otherwise equivalent to using `enabledCollectors` above.
    extraFlags = [ "--collector.ntp.protocol-version=4" "--no-collector.mdadm" ];
  };
}
