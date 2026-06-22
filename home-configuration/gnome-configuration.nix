{ config, lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = true;
      max-accuracy-level = "exact";
    };
    "org/gnome/nautilus/preferences" = {
      date-time-format = "datailed";
      default-folder-view = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };
    "org/gnome/nautilus/icon-view" = {
      captions = [ "size" "type" "none" ];
    };
    "org/gnome/desktop/background" = {
      picture-options = "none";
      primary-color = "#282828";
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close:appmenu";
      # action-right-click-titlebar = "minimize";
      # action-middle-click-titlebar = "lower";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
      screensaver = [ "<Control><Super>q" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "/run/current-system/sw/bin/nautilus --new-window";
      name = "Nautilus";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>w";
      command = "ghostty";
      name = "Ghostty";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "Print";
      command = "/etc/profiles/per-user/whatever/bin/gnome-screenshot --interactive";
      name = "Screenshot";
    };
    "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [];
        toggle-application-view = [ "<Super>space" ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Alt><Super>j" ];
      toggle-tiled-right = [ "<Alt><Super>l" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = [ "<Alt><Super>k" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        caffeine.extensionUuid
        dash-to-panel.extensionUuid
        date-menu-formatter.extensionUuid
        night-theme-switcher.extensionUuid
        no-overview.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/date-menu-formatter" = {
      pattern = "EEEE, d MMMM yyyy   ☉   HH:mm:ss";
      text-align = "right";
      update-level = "2";
    };
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = "2";
      restore-state = true;
      show-indicator = "always";
      show-notifications = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enable = true;
      natural-scroll = false;
    };
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };  
}
